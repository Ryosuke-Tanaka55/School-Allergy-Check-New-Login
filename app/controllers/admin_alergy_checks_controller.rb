class AdminAlergyChecksController < ApplicationController
    include SchoolsHelper
    UPDATE_ERROR_MSG = "登録に失敗しました。やり直してください。"

    before_action :signed_in_teacher
    before_action :system_admin_inaccessible
    before_action :set_school
    before_action :admin_teacher, only: [:one_month_index]
    before_action :set_first_last_day
    before_action :admin_teacher, only: [:show]

    def one_month_index
      @alergy_checks = AlergyCheck.joins({student: {classroom: :school}})
                                  .where(:schools =>{:id => current_teacher.school_id}, worked_on: @first_day..@last_day)
                                  .order(:worked_on)
    end

    def show
      @teacher = current_teacher #Teacher.find(params[:id])
      @approval = AlergyCheck.joins({student: {classroom: :school}})
                              .where(:schools =>{:id => current_teacher.school_id}, worked_on: Date.current, status: "確認済").where.not(applicant: nil).count #報告済み件数
      @rechecked = AlergyCheck.joins({student: {classroom: :school}})
                              .where(:schools =>{:id => current_teacher.school_id}, worked_on: Date.current, status: "要再確認").where.not(applicant: nil).count #要再確認件数
      @lunch_check_sum = AlergyCheck.joins({student: {classroom: :school}})
                                    .where(:schools =>{:id => current_teacher.school_id}, worked_on: Date.current).where.not(applicant: nil).count
      @lunch_check_rest = @lunch_check_sum - @approval - @rechecked

    end

    def lunch_check_info
      orders = AlergyCheck.joins({student: {classroom: :school}})
                         .where(:schools =>{:id => current_teacher.school_id}, worked_on: Date.current).where.not(applicant: nil)
                         .select("alergy_checks.*, students.classroom_id").order('classrooms.id')
      @requesters = orders.where(:schools =>{:id => current_teacher.school_id}, worked_on: Date.current).where.not(applicant: nil)
                          .select("alergy_checks.*, students.classroom_id").group_by{|record|record.classroom_id}
    end

    def update_lunch_check_info
      updated_ad = 0
      remained_ad = 0
      @user = current_teacher #Teacher.find(params[:id])
      @info_sum = AlergyCheck.joins({student: {classroom: :school}})
                             .where(:schools =>{:id => current_teacher.school_id}, worked_on: Date.current, status: "確認済").where.not(applicant: nil).count #報告済み件数
      @unapproval_info_sum = AlergyCheck.joins({student: {classroom: :school}})
                                        .where(:schools =>{:id => current_teacher.school_id}, worked_on: Date.current, status: "要再確認").where.not(applicant: nil).count

      #保存判定
      lunch_check_info_params.each do |id, item|
        if item['status_checker'] == "1" && item['status'] == "確認済"
          attendance = AlergyCheck.find(id)
          attendance.admin_name = @user.teacher_name
          attendance.update_attributes!(admin_name: @user.teacher_name)
          attendance.update_attributes!(item)
          @info_sum += 1
          updated_ad += 1
        elsif item['status_checker'] == "1" && item['status'] == "要再確認"
          attendance = AlergyCheck.find(id)
          attendance.admin_name = @user.teacher_name
          attendance.update_attributes!(admin_name: @user.teacher_name)
          attendance.update_attributes!(item)
          @unapproval_info_sum += 1
          updated_ad += 1
        elsif item['status_checker'] == "1" && item['status'] == "報告中"
          remained_ad += 1
        elsif item['status_checker'] == "0" && item['status'] == "確認済"
          remained_ad += 1
        end #if end
      end #each end

     #更新後のメッセージ表示
     if updated_ad >= 1 && remained_ad == 0
      flash[:success] = "確認済#{@info_sum}件、要再確認#{@unapproval_info_sum}件"
      redirect_to teachers_admin_alergy_checks_url
     elsif updated_ad >= 1 && remained_ad >= 1
      flash[:success] = "確認済#{@info_sum}件、要再確認#{@unapproval_info_sum}件"
      flash[:warning] = "正しく選択されていない件名があります"
      redirect_to teachers_admin_alergy_checks_url
     elsif updated_ad == 0 && remained_ad >= 1
      respond_to do |format|
       format.js { flash.now[:danger] = "正しく選択されていない件名があります"}
       format.js { render 'lunch_check_info' }
      end
     elsif updated_ad == 0 && remained_ad == 0
      redirect_to teachers_admin_alergy_checks_url
     end #if end
    end #def end

private

# schoolの特定
    def set_school
      @school = current_school
    end

    def lunch_check_info_params
      params.permit(attendances: [:status, :status_checker])[:attendances].merge(admin_name: current_teacher.teacher_name)
    end
  end
