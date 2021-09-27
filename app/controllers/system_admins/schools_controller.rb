class SystemAdmins::SchoolsController < ApplicationController
  before_action :set_school, only: %i[ show edit update destroy ]

  def index
    @schools = School.all
  end

  def show
  end

  def new
    @school = School.new
  end

  def edit
  end

  def create
    @school = School.new(school_params)
    @school.save!
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
      params.require(:school).permit(:school_name, :school_url)
    end

end
