class TeachersController < ApplicationController
  # before_action :authenticate_teacher!

  def show
    @teacher = Teacher.find(params[:id])
  end

  # 対応法担当者ページ(show)
  def creator
    @days_of_the_week = %w{日 月 火 水 木 金 土}
    @first_day = params[:date].nil? ? Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    @one_month = [*@first_day..@last_day]
    @students = Student.all
  end
end
