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
    @classrooms = current_teacher.school.classrooms.where(using_class: true)
  end

  def create
    AlergyCheck.transaction do
      params[:student][:alergy_checks_attributes].each do |_, v|
        student = current_teacher.school.students.find(v[:student_id])
        if v[:_destroy] == "false"
          student.alergy_checks.create!(
            worked_on:  v[:worked_on],
            menu:       v[:menu],
            support:    v[:support],
            note:       v[:note]
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
    @alergy_check = AlergyCheck.find(params[:id])
    @student = @alergy_check.student
    @classroom = current_teacher.school.classrooms.find(@student.classroom_id)
    @classrooms = current_teacher.school.classrooms.where(using_class: true)
  end

  def update
    if params[:alergy_check][:student_id].present?
      @alergy_check = AlergyCheck.find(params[:id])
      if @alergy_check.update(edit_creator_params)
        flash[:success] = "#{l(@alergy_check.worked_on, format: :short)}の情報を更新しました。"
      else
        flash[:danger] = "更新に失敗しました。<br>" + "・" + @alergy_check.errors.full_messages.join("<br>")
      end
    elsif params[:alergy_check][:student_id].nil?
      flash[:danger] = "登録に失敗しました。児童の情報が存在しません。入力内容を確認してください。"
    else
      flash[:danger] = "登録に失敗しました。児童名を選択してください。"
    end
    redirect_to teachers_creator_alergy_checks_url
  end

  def destroy
    @alergy_check = AlergyCheck.find(params[:id])
    @student = @alergy_check.student
    @alergy_check.destroy
    flash[:success] = "#{l(@alergy_check.worked_on, format: :short)}、#{@student.student_name}の情報を削除しました。"
    redirect_to teachers_creator_alergy_checks_url
  end

  def search_student
    students = current_teacher.school.classrooms.find_by(id: params[:classroom_id]).students
    response = students.map{|student| [student.id, student.student_name]}
    render json: response
  end

  private
    def edit_creator_params
      params.require(:alergy_check).permit(:student_id, :menu, :support, :note)
    end
end