class SystemAdmins::TeachersController < ApplicationController
  before_action :authenticate_system_admin!
  before_action :set_school, only: %i[ new create destroy]
  before_action :set_admin_teacher, only: %i[ show edit update destroy ]

  def index
  end

  def new
    @admin_teacher = @school.teachers.new
  end

  def create
    @admin_teacher = @school.teachers.new(admin_teacher_params)
    @admin_teacher.admin = true
    if @admin_teacher.save
      flash[:info] = "学校管理者を作成しました"
      redirect_to system_admins_schools_path
    else
      flash[:danger] = "作成に失敗しました"
      render :new
    end
  end

  def destroy
    @admin_teacher.destroy
    flash[:danger] = "#{@admin_teacher.teacher_name}を削除しました。"
    redirect_to system_admins_schools_path
  end

  private

    # schoolの特定
    def set_school
      @school = School.find_by!(school_url: params[:school_id])
    end

    def set_admin_teacher
      @admin_teacher = @school.teachers.find_by!(tcode: params[:tcode])
    end

    def admin_teacher_params
      params.require(:teacher).permit(:teacher_name, :tcode, :email, :password, :password_confirmation, :school_id)
    end

end


