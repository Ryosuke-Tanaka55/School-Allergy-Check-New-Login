class TeachersController < ApplicationController
  # before_action :authenticate_teacher!

  def show
    @teacher = Teacher.find(params[:id])
  end

  # 対応法担当者ページ(show)
  def creator
    
  end
end
