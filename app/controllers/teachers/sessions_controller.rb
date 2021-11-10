# frozen_string_literal: true

class Teachers::SessionsController < Devise::SessionsController
  before_action :set_school
  before_action :configure_sign_in_params, only: [:create]

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

  # ログイン時のストロングパラメータ
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: %i(tcode))
  end

   # schoolの特定
   def set_school
    @school = School.find_by(school_url: params[:school_url])
  end
end
