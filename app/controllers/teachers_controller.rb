class TeachersController < ApplicationController
  include SchoolsHelper

  before_action :authenticate_teacher!
  before_action :admin_teacher, only: [:new, :create, :edit_info, :update_info, :destroy]
  before_action :set_first_last_day, only: :creator


  def index
    @teachers = current_school.teachers.all
  end

  def show
    # @teacher = Teacher.find(params[:id])
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
      flash[:danger] = "作成に失敗しました。<br>・#{@teacher.errors.full_messages.join('<br>・')}"
    end
    redirect_to classrooms_path and return
  end

  def edit_info
    @teacher = current_school.teachers.find(params[:id])
  end

  def update_info
    @teacher = current_school.teachers.find(params[:teacher][:id])
    if @teacher.update_attributes!(teachers_params)
      flash[:success] = "職員情報を更新しました。"
      redirect_to classrooms_path
    else
      render :edit
    end
  end

  def destroy
    @teacher = current_school.teachers.find(params[:id])
    @teacher.destroy
    flash[:danger] = "#{@teacher.teacher_name}を削除しました。"
    redirect_to classrooms_path
  end

  # 対応法担当者ページ(show)
  def creator
    @days_of_the_week = %w{日 月 火 水 木 金 土}
    @one_month = [*@first_day..@last_day]
    @students = Student.all
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
