class AlergyChecksController < ApplicationController

  def general_show
    @alergy_check_sum = Classroom.find(current_teacher.classroom_id).alergy_checks.all.count
  end

  def index
  end

  def update
  end

  def index_one_month
  end
end
