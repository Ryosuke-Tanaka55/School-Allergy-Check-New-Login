# frozen_string_literal: true

class Teachers::SessionsController < Devise::SessionsController
  # before_action :system_admin_not_show, only: [:create]
  before_action :check_current_system_admin, only: [:new]
  before_action :set_school, only: %i[new create]
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    unless @school == resource.school
      sign_out(resource_name)
      flash[:danger] = 'ログイン情報が間違ってます。'
      redirect_to new_teacher_session_url(school_url: @school.school_url) and return
    end
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    self.resource = warden.authenticate!(auth_options)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    redirect_to new_teacher_session_url(school_url: resource.school.school_url)
  end

  # protected

  # ログイン時のストロングパラメータ
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[tcode])
  end

  # schoolの特定
  def set_school
    @school = School.find_by!(school_url: params[:school_url])
  end

  # # システム管理者ログイン中、システム管理者自身が職員ログインできないようにする
  # def system_admin_not_show
  #   if system_admin_signed_in?
  #     flash[:danger] = "学校の職員のみ遷移可能です。"
  #     redirect_to classrooms_path
  #   end
  # end

  private

  def check_current_system_admin
    if current_system_admin
      flash[:danger] = '現在システム管理者でログイン中です。職員でログインする場合は一度ログアウトしてください。'
      redirect_to system_admins_schools_url
    end
  end
end
