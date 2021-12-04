class AdminAlergyChecksController < ApplicationController
before_action :set_first_last_day

  def one_month_index
    @alergy_checks = AlergyCheck.joins({student: {classroom: :school}})
                                .where(:schools =>{:id => current_teacher.school_id}, worked_on: @first_day..@last_day)
                                .order(:worked_on)
  end

end