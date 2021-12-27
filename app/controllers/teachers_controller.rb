class TeachersController < ApplicationController
  include SchoolsHelper
  before_action :signed_in_teacher
  before_action :system_admin_inaccessible
  before_action :admin_teacher, only: [:new, :create, :edit_info, :update_info, :destroy]

  def show
  end

  def new
    @teacher = current_school.teachers.new
  end

  def create
    @teacher = current_school.teachers.new(teachers_params)
    if @teacher.save
      flash[:success] = "担任を作成しました。"
      redirect_to classrooms_path and return
    else
      respond_to do |format|
        format.js { flash.now[:danger] = "更新に失敗しました。<br>・#{@teacher.errors.full_messages.join('<br>・')}"} 
        format.js { render 'new' }
      end
    end
  end

  def edit_info
    @teacher = current_school.teachers.find(params[:id])
    @classrooms = current_teacher.school.classrooms.where(using_class: true).order(:id)
  end

  def update_info
    @teacher = current_school.teachers.find(params[:teacher][:id])
    if @teacher.update_attributes(teachers_params)
      flash[:success] = "#{@teacher.teacher_name}の情報を更新しました。"
      redirect_to classrooms_path
    else
      respond_to do |format|
        format.js { flash.now[:danger] = "更新に失敗しました。<br>・#{@teacher.errors.full_messages.join('<br>・')}"} 
        format.js { render 'edit_info' }
      end
    end
  end

  def destroy
    @teacher = current_school.teachers.find(params[:id])
    @teacher.destroy
    flash[:danger] = "#{@teacher.teacher_name}を削除しました。"
    redirect_to classrooms_path
  end

  private

    def teachers_params
      params.require(:teacher).permit(:teacher_name, :email, :tcode, :password, :password_confirmation, :school_id, :classroom_id, :admin, :creator, :charger)
    end

    # アクセスした職員が現在ログインしている職員か確認
    def correct_teacher
      redirect_to top_path unless current_teacher?(@teacher)
    end

end
