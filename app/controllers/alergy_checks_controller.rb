class AlergyChecksController < ApplicationController

  def show
    @alergy_check_sum = Classroom.find(current_teacher.classroom_id).alergy_checks.all.count
  end

  def today_index
  end

  def update
  end

  def one_month_index
  end
end
