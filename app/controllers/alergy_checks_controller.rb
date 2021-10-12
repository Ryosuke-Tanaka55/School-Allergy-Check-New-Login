class AlergyChecksController < ApplicationController
  def new
    @alergy_check = AlergyCheck.new
    @day = params[:day].to_date
    @classrooms = Classroom.all
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
