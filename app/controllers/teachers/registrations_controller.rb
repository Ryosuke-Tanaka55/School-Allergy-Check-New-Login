# frozen_string_literal: true
# 下記アクションの内、結局editしか使っていない状況（12/16）

class Teachers::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel] # ログイン後も新規登録を可能にする為、new、createを外す
  prepend_before_action :system_admin_inaccessible
  before_action :creatable?, only: [:new, :create]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :admin_teacher, only: [:new, :create, :edit, :update, :destroy]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create    
    if Teacher.create!(ippan_sign_up_params)
      flash[:success] = "職員を作成しました。"
      redirect_to classrooms_path
    else
      flash[:danger] = "作成に失敗しました。"
      render :new
    end
  end

  # GET /resource/edit
  def edit
    @classrooms = current_teacher.school.classrooms.where(using_class: true).order(:id)
  end

  # PUT /resource
  def update
    @classrooms = current_teacher.school.classrooms.where(using_class: true).order(:id)
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # 学校管理者新規登録時のストロングパラメーター
  def configure_sign_up_params
    # if system_admin_signed_in?
      devise_parameter_sanitizer.permit(:sign_up, keys: %i(teacher_name tcode email password password_confirmation school_id classroom_id))
    # elsif current_teacher.present? && current_teacher.admin?
      # devise_parameter_sanitizer.permit(:sign_up, keys: %i(teacher_name tcode password school_id classroom_id))
    # end
  end

  # 学校管理者アカウント編集時のストロングパラメーター
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:teacher_name, :tcode, :email, :password, :password_confirmation, :admin, :creator, :charger, :school_id, :classroom_id])
  end

  # 一般職員新規登録時のストロングパラメーター
  def ippan_sign_up_params
    params.require(:teacher).permit(:teacher_name, :tcode, :password, :password_confirmation, :school_id, :classroom_id, :admin, :creator, :charger)
    # devise_parameter_sanitizer.permit(:sign_up, keys: %i(teacher_name tcode password school_id classroom_id))
  end

  # 学校管理者かどうかの判定
  def current_teacher_is_admin?
    teacher_signed_in? && current_teacher.admin?
  end

  # 学校管理者でなければログインに遷移
  def sign_up(resource_name, resource)
    if !current_teacher_is_admin?
      sign_in(resource_name, resource)
    end
  end

  # 管理者のみログイン後も新規登録できるようにする
  def creatable?
    if !current_teacher_is_admin? && !system_admin_signed_in?
      flash[:danger] = "新規登録は管理者のみ行えます"
      redirect_to teachers_path
    end
  end

  # アカウント編集後の遷移先
  def after_update_path_for(resource)
    show_teachers_path
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
