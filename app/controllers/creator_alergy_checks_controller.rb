class CreatorAlergyChecksController < ApplicationController
  before_action :set_first_last_day, only: :index

  def index
    @one_month = [*@first_day..@last_day]
    @students = Student.all
  end

  def new
    @student = Student.new
    @alergy_check = @student.alergy_checks.build
    @day = params[:day].to_date
    @classrooms = current_teacher.school.classrooms
  end

  def create
    AlergyCheck.transaction do
      params[:student][:alergy_checks_attributes].each do |_, v|
        student = current_teacher.school.students.find(v[:student_id])
        if v[:_destroy] == "false"
          student.alergy_checks.create!(
            worked_on:  v[:worked_on],
            menu:       v[:menu],
            support:    v[:support]
          )
        end
      end
    end
    flash[:success] = 'アレルギー情報を登録しました。'
    redirect_to teachers_creator_alergy_checks_url

  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
    flash[:danger] = e.message
    redirect_to teachers_creator_alergy_checks_url
  end

  def edit
  end

  def update
  end

  def destroy
  end
end