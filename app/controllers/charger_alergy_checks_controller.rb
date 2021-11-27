class ChargerAlergyChecksController < ApplicationController

def show
  @classrooms = Classroom.where(school_id: current_teacher.school.id)
end

end