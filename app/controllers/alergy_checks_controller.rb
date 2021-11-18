class AlergyChecksController < ApplicationController
  before_action :set_classroom, only: [:show, :today_index]

  def show
    @alergy_check_sum = @classroom.alergy_checks.where(worked_on: Date.current).count #本日のチェック件数
    @submitted = @classroom.alergy_checks.where(worked_on: Date.current).where.not(status: "").count #報告済み件数
  end

  def today_index
    @alergy_checks = @classroom.alergy_checks.where(worked_on: Date.current).order(:student_id)
    @teachers = Teacher.where.not(creator: true)
  end

  def update
    @alergy_check = AlergyCheck.find(params[:alergy_check][:alergy_check_id])
    if @alergy_check.update_attributes(today_check_params)
      flash[:success] = "#{@alergy_check.student.student_name}のチェックを報告しました。"
    else
      flash[:danger] = "チェックの報告に失敗しました。入力項目を確認してください。"
    end
    redirect_to teachers_alergy_checks_url
  end

  def one_month_index
  end

  private
    def set_classroom
      @classroom = Classroom.find(current_teacher.classroom_id)
    end

    def today_check_params
      params.require(:alergy_check).permit(:first_check, :second_check, :student_check, :applicant_id).merge(status: "報告中")
    end
end
