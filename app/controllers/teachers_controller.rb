class TeachersController < ApplicationController
  # before_action :authenticate_teacher!

  def show
    @teacher = Teacher.find(params[:id])
  end
end
