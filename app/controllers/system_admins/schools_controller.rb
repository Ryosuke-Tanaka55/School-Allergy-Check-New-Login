class SystemAdmins::SchoolsController < ApplicationController
  before_action :authenticate_system_admin!

  def index
    @schools = School.all
  end

  def show
  end

  def edit
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    set_class
    if @school.save
      flash[:info] = "学校を新規作成しました"
      redirect_to system_admins_schools_url
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private




    def school_params
      # params.require(:school).permit(:school_name, :school_url, classrooms_attributes:[:school_id, :class_name])
      params.require(:school).permit(:school_name, :school_url)
    end

    def set_class
      # @classrooms = @school.classrooms.create(class_name)
      @classrooms = @school.classrooms.build([
        {class_name: "1-1", class_grade: 1},
        {class_name: "1-2", class_grade: 1},
        {class_name: "1-3", class_grade: 1},
        {class_name: "1-4", class_grade: 1},
        {class_name: "1-5", class_grade: 1},
        {class_name: "1-6", class_grade: 1},
        {class_name: "1-7", class_grade: 1},
        {class_name: "1-8", class_grade: 1},
        {class_name: "2-1", class_grade: 2},
        {class_name: "2-2", class_grade: 2},
        {class_name: "2-3", class_grade: 2},
        {class_name: "2-4", class_grade: 2},
        {class_name: "2-5", class_grade: 2},
        {class_name: "2-6", class_grade: 2},
        {class_name: "2-7", class_grade: 2},
        {class_name: "2-8", class_grade: 2},
        {class_name: "3-1", class_grade: 3},
        {class_name: "3-2", class_grade: 3},
        {class_name: "3-3", class_grade: 3},
        {class_name: "3-4", class_grade: 3},
        {class_name: "3-5", class_grade: 3},
        {class_name: "3-6", class_grade: 3},
        {class_name: "3-7", class_grade: 3},
        {class_name: "3-8", class_grade: 3},
        {class_name: "4-1", class_grade: 4},
        {class_name: "4-2", class_grade: 4},
        {class_name: "4-3", class_grade: 4},
        {class_name: "4-4", class_grade: 4},
        {class_name: "4-5", class_grade: 4},
        {class_name: "4-6", class_grade: 4},
        {class_name: "4-7", class_grade: 4},
        {class_name: "4-8", class_grade: 4},
        {class_name: "5-1", class_grade: 5},
        {class_name: "5-2", class_grade: 5},
        {class_name: "5-3", class_grade: 5},
        {class_name: "5-4", class_grade: 5},
        {class_name: "5-5", class_grade: 5},
        {class_name: "5-6", class_grade: 5},
        {class_name: "5-7", class_grade: 5},
        {class_name: "5-8", class_grade: 5},
        {class_name: "6-1", class_grade: 6},
        {class_name: "6-2", class_grade: 6},
        {class_name: "6-3", class_grade: 6},
        {class_name: "6-4", class_grade: 6},
        {class_name: "6-5", class_grade: 6},
        {class_name: "6-6", class_grade: 6},
        {class_name: "6-7", class_grade: 6},
        {class_name: "6-8", class_grade: 6},
        {class_name: "特別学級１", class_grade: 7},
        {class_name: "特別学級２", class_grade: 7},
        {class_name: "特別学級３", class_grade: 7},
        {class_name: "特別学級４", class_grade: 7},
        {class_name: "特別学級５", class_grade: 7}
      ])

    end

end
