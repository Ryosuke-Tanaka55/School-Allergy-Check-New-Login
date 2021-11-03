class TeachersController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_school


  def show
    # @teacher = Teacher.find(params[:id])
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teachers_params)
    if @teacher.save
      flash[:success] = "担任を作成しました。"
      redirect_to classrooms_path(school_url: params[:school_url])
    else
      flash[:danger] = "作成に失敗しました。"
      render :new
    end
  end

  def edit_info
    @teacher = Teacher.find(params[:id])
  end

  def update_info
    @teacher = Teacher.find(params[:teacher][:id])
    if @teacher.update_attributes!(teachers_params)
      flash[:success] = "担任情報を更新しました。"
      redirect_to classrooms_path(school_url: params[:school_url])
    else
      render :edit
    end
  end


  private

    # schoolの特定
    def set_school
      @school = School.find_by(school_url: params[:school_url])
    end

    def teachers_params
      params.require(:teacher).permit(:teacher_name, :tcode, :password, :password_confirmation, :school_id, :classroom_id)
    end
  
end
