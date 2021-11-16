class AlergyChecksController < ApplicationController
  before_action :set_classroom, only: [:show, :today_index]

  def show
    @alergy_check_sum = @classroom.alergy_checks.all.where(worked_on: Date.current).count
    #.allと.where(status: "")の数の差分がゼロの時、「本日のチェックは完了しました」と表示する
  end

  def today_index
    @alergy_checks = @classroom.alergy_checks.all.where(worked_on: Date.current) #本日の日付のものに限る
    @teachers = Teacher.where.not(creator: true) #対応法担当者は除く
  end

  def update
    @alergy_check = AlergyCheck.find(params[:alergy_check][:alergy_check_id])
  end

  def one_month_index
  end

  private
    def set_classroom
      @classroom = Classroom.find(current_teacher.classroom_id)
    end

    def today_check_params
      
    end
end
