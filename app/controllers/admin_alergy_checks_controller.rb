class AdminAlergyChecksController < ApplicationController
    UPDATE_ERROR_MSG = "登録に失敗しました。やり直してください。"
    before_action :set_first_last_day

    def one_month_index
      @alergy_checks = AlergyCheck.joins({student: {classroom: :school}})
                                  .where(:schools =>{:id => current_teacher.school_id}, worked_on: @first_day..@last_day)
                                  .order(:worked_on)
    end

    def show
      @teacher = Teacher.find(params[:id])
      @lunch_check_sum = AlergyCheck.where(status: "報告中").count
      @users = User.joins(:attendances).where(attendances: {status: "確認済"})
      @checks = Attendance.where(worked_on: @first_day..@last_day).where(status: "確認済").order(:worked_on, :user_id)
      @un_checks = Attendance.where(worked_on: @first_day..@last_day).where.not(status: "報告中").where.not(status: "確認済").where.not(status: "要確認").order(:worked_on, :user_id)
    end  
  
    def update
       @user = User.find(params[:user_id])
       @attendance = Attendance.find(params[:id])
       # 出勤時間が未登録であることを判定します。
       if @attendance.started_at.nil?
         if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
           flash[:info] = "給食の時間です！"
         else
           flash[:danger] = UPDATE_ERROR_MSG
         end
       elsif @attendance.finished_at.nil?
         if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
           flash[:info] = "お疲れ様でした。"
         else
           flash[:danger] = UPDATE_ERROR_MSG
         end
       end
       redirect_to @user
    end
   
   
    def lunch_check #アレルギーチェック
       @user = User.find(params[:user_id])
       @attendance = Attendance.find(params[:id])
       @superiors = User.where(superior: true).where.not(id: @user.id)
    end
    
    def update_lunch_check
     #アレルギーチェックのアップデート
     @user = User.find(params[:user_id])
     @attendance = Attendance.find(params[:id])
     if params[:attendance][:first_teacher] == "0" || params[:attendance][:second_teacher] == "0" || params[:attendance][:student] == "0"
        flash[:danger] = "#{@user.name}さん,チェックをすべてしてください。 "
     elsif params[:attendance][:lunch_check_superior].blank? 
           flash[:danger] = "アレルギー担当者を選択して下さい。 "
     else  
        # 更新時の処理
        params[:attendance][:status] = "報告中"
        @attendance.update_attributes(lunch_check_params)
        flash[:success] = "#{@user.name}さんがアレルギーチェックをしました。"
        
     end 
       redirect_to user_url(@user)   
    end
    
    def lunch_check_info 
      #debugger
      @teacher = Teacher.find(params[:id])
      @requesters = AlergyCheck.where(status: "報告中").group_by(&:applicant)
    end 
    
    def update_lunch_check_info
      
      @user = Teacher.find(params[:id])
      ActiveRecord::Base.transaction do 
       lunch_check_info_params.each do |id, item|
         if item[:status_checker] == "1"
           attendance = AlergyCheck.find(id)
           attendance.admin_name = @user.teacher_name
           attendance.update_attributes!(admin_name: @user.teacher_name)
           attendance.update_attributes!(item)
            @info_sum = AlergyCheck.where(status: "確認済").count
            @unapproval_info_sum = AlergyCheck.where(status: "要再確認").count
            flash[:success] = "確認済#{@info_sum}件、要再確認#{@unapproval_info_sum}件"
         end #if end 
       end #each end 
       redirect_to teachers_admin_alergy_check_url(@user)
     end #Acctive do end    
    #def end
    rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    end #def end
    
    def lunch_check_all 
      @user = User.find(params[:user_id])
      @requesters = Attendance.where(lunch_check_superior: @user.name, status: "報告中").order(:user_id).group_by(&:user_id)
    end 
    
    def update_lunch_check_all
      
      @user = User.find(params[:user_id])
      ActiveRecord::Base.transaction do 
       lunch_check_all_params.each do |id, item|
         if item[:status_checker] == "1"
           attendance = Attendance.find(id)
           attendance.update_attributes!(item)
            @info_sum = Attendance.where(status: "確認済").count
            @unapproval_info_sum = Attendance.where(status: "要再確認").count
            flash[:success] = "確認済#{@info_sum}件、要再確認#{@unapproval_info_sum}件"
         end #if end 
       end #each end 
       redirect_to user_url(@user)
     end #Acctive do end    
    #def end
    rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    end #def end
    
    private
     def lunch_check_params
       params.require(:attendance).permit(:first_teacher, :second_teacher, :student, :lunch_check_superior, :status, :note)  
     end 
     
     def lunch_check_info_params 
      params.require(:teacher).permit(attendances: [:status, :status_checker, :admin_name])[:attendances]
     end  
     
     
  end
