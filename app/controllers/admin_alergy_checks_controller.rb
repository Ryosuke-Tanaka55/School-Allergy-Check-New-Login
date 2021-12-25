class AdminAlergyChecksController < ApplicationController
    include SchoolsHelper
    include AjaxHelper
    UPDATE_ERROR_MSG = "登録に失敗しました。やり直してください。"

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
                             .where(:schools =>{:id => current_teacher.school_id}, worked_on: Date.current, status: "確認済").count #報告済み件数
      @lunch_check_sum = AlergyCheck.joins({student: {classroom: :school}})
                                    .where(:schools =>{:id => current_teacher.school_id}, worked_on: Date.current).count
      @lunch_check_rest = @lunch_check_sum - @approval

    end

    def lunch_check_info
      @requesters = AlergyCheck.joins({student: {classroom: :school}})
                               .where(:schools =>{:id => current_teacher.school_id}, worked_on: Date.current)
                               .select("alergy_checks.*, students.classroom_id").group_by{|record|record.classroom_id}

    end

    def update_lunch_check_info
      @user = current_teacher #Teacher.find(params[:id])
      ActiveRecord::Base.transaction do
       lunch_check_info_params.each do |id, item|
         if item['status_checker'] == "1" && item['status'] == "確認済"
          attendance = AlergyCheck.find(id)
          attendance.admin_name = @user.teacher_name
          attendance.update_attributes!(admin_name: @user.teacher_name)
          attendance.update_attributes!(item)
           @info_sum = AlergyCheck.where(worked_on: Date.current, status: "確認済").count
           @unapproval_info_sum = AlergyCheck.where(worked_on: Date.current, status: "要再確認").count
           flash[:success] = "確認済#{@info_sum}件、要再確認#{@unapproval_info_sum}件"
         elsif item['status_checker'] == "1" && item['status'] == "要再確認"
          attendance = AlergyCheck.find(id)
          attendance.admin_name = @user.teacher_name
          attendance.update_attributes!(admin_name: @user.teacher_name)
          attendance.update_attributes!(item)
           @info_sum = AlergyCheck.where(worked_on: Date.current, status: "確認済").count
           @unapproval_info_sum = AlergyCheck.where(worked_on: Date.current, status: "要再確認").count
           flash[:success] = "確認済#{@info_sum}件、要再確認#{@unapproval_info_sum}件"
         elsif item['status_checker'] == "1" && item['status'] == "報告中"
           flash[:danger] = "正しく選択されていない件名があります"
         elsif item['status_checker'] == "0" && item['status'] == "確認済"
           flash[:danger] = "正しく選択されていない件名があります"
        end #if end
       end #each end
       redirect_to teachers_admin_alergy_checks_url
     end #Acctive do end
    #def end
    rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to teachers_admin_alergy_checks_url
      #respond_to do |format|
      #  format.js { render ajax_redirect_to(lunch_check_info_teachers_admin_alergy_checks_path) }
      #end
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
