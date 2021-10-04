class SystemAdmins::SchoolsController < ApplicationController
  before_action :set_school, only: %i[ show edit update destroy ]

  def index
    @schools = School.all
  end

  def show
  end

  def edit
  end
  
  def new
    @school = School.new
    # @school.classrooms.build
  end

  def create
    @school = School.new(school_params)
    if @school.save
      flash[:info] = "学校を新規作成しました"
      redirect_to system_admins_path
    else
      flash[:danger] = "作成に失敗しました"
    end
  end

  def update
  end

  def destroy
  end

  private
    def set_school
      @school = School.find(params[:id])
    end

    def school_params
      # params.require(:school).permit(:school_name, :school_url, classrooms_attributes:[:school_id, :class_name])
      params.require(:school).permit(:school_name, :school_url)
    end

    def set_class
      @classrooms = @school.classrooms.create(class_name)
    end

end
