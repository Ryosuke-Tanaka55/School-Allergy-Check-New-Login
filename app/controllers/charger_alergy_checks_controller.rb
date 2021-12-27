class ChargerAlergyChecksController < ApplicationController
  before_action :signed_in_teacher
  before_action :system_admin_inaccessible
  before_action :charger_teacher

  def show
    # ログインしている職員の学校内で、本日チェックが必要なアレルギー情報を抽出
    @classrooms = Classroom.includes(students: :alergy_checks).where(school_id: current_teacher.school.id, alergy_checks: {worked_on: Date.current})
  end

  private
    # 代理報告権限を持つ職員かどうかの判定
    def charger_teacher
      unless current_teacher.charger? || current_teacher.admin?
        flash[:danger] = "アクセス権限がありません。"
        redirect_to show_teachers_path
      end
    end
end