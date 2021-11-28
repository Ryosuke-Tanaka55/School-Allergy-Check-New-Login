class ChargerAlergyChecksController < ApplicationController

  def show
    @classrooms = Classroom.includes(students: :alergy_checks).where(school_id: current_teacher.school.id, alergy_checks: {worked_on: Date.current})
  end

end