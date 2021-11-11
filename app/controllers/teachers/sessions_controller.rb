# frozen_string_literal: true

class Teachers::SessionsController < Devise::SessionsController
  before_action :set_school, only: [:new, :create]
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
    devise_parameter_sanitizer.permit(:sign_in, keys: %i(tcode))
  end

  # schoolの特定
  def set_school
  @school = School.find_by!(school_url: params[:school_url])
  end

end
