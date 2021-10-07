class SystemAdmins::TeachersController < ApplicationController
  before_action :set_admin_teacher, only: %i[ show edit update destroy ]

  def index
  end

  def new
    @school = School.find(params[:school_id])
    @admin_teacher = @school.teachers.new
  end

  def create
    @school = School.find(params[:school_id])
    @admin_teacher = @school.teachers.new(admin_teacher_params)
    @admin_teacher.admin = true
    if @admin_teacher.save
      flash[:info] = "学校管理者を作成しました"
      redirect_to system_admins_school_teacher_path(@school, @admin_teacher)
    else
      flash[:danger] = "作成に失敗しました"
      render :new
    end
  end

  def destroy
  end

  private
    def set_admin_teacher
      @admin_teacher = Teacher.find(params[:id])
    end

    def admin_teacher_params
      params.require(:teacher).permit(:teacher_name, :email, :password, :password_confirmation)
    end

end


