# frozen_string_literal: true

class SystemAdmins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :check_current_teacher, only: [:new]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def check_current_teacher
    if current_teacher
      flash[:danger] = '現在職員でログイン中です。システム管理者でログインする場合は一度ログアウトしてください。'
      redirect_to show_teachers_url
    end
  end
end
