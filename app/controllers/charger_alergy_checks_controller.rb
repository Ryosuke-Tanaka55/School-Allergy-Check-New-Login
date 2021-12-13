class ChargerAlergyChecksController < ApplicationController

  def show
    # ログインしている職員の学校内で、本日チェックが必要なアレルギー情報を抽出
    @classrooms = Classroom.includes(students: :alergy_checks).where(school_id: current_teacher.school.id, alergy_checks: {worked_on: Date.current})
  end

end