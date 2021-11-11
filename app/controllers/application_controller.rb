class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper


  # ---------下記既存アプリの記述-------------------
  $days_of_the_week = %w{日 月 火 水 木 金 土}

  # ページ出力前に1ヶ月分のデータの存在を確認・セットします。
 def set_one_month
  @first_day = params[:date].nil? ?
  Date.current.beginning_of_month : params[:date].to_date
  @last_day = @first_day.end_of_month
  one_month = [*@first_day..@last_day]

  @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)

  unless one_month.count == @attendances.count
    ActiveRecord::Base.transaction do
      one_month.each { |day| @user.attendances.create!(worked_on: day) }
    end
    @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
  end

  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end
  # ---------------------------------------------

  # ログイン後に遷移するpathを設定
  def after_sign_in_path_for(resource)
    case resource
    when SystemAdmin
      system_admins_path
    when Teacher
      if current_teacher.admin == true && resource.sign_in_count == 1
        edit_using_class_classrooms_path
      else
        show_teachers_path
      end
    end
  end

  # 管理者かどうかの判定
  def admin_teacher
    redirect_to top_pathaaaa unless current_teacher.admin?
  end
end
