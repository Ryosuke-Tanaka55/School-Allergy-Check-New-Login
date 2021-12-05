class CreatorAlergyChecksController < ApplicationController
  before_action :set_first_last_day, only: :index

  def index
    @one_month = [*@first_day..@last_day]
    @students = Student.all
  end

  def new
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