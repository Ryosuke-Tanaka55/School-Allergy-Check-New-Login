class AlergyChecksController < ApplicationController
  before_action :set_classroom, only: [:show, :today_index, :one_month_index]
  before_action :set_first_last_day, only: :one_month_index
  before_action :have_class_room?, only: :one_month_index

  def show
    @submitted = @classroom.alergy_checks.today.where.not(status: "").count #報告済み件数
    @alergy_check_sum = @classroom.alergy_checks.today.count
  end

  def today_index
    @alergy_checks = @classroom.alergy_checks.today.order(:student_id)
    @teachers = Teacher.where(school_id: current_teacher.school_id) # 代理報告時に選択
  end

  def update
    @alergy_check = AlergyCheck.find(params[:alergy_check][:alergy_check_id])
    # 同じschool_idを持つ児童しか選択できない
    if current_teacher.school.id != @alergy_check.student.school_id
      flash[:danger] = "許可されていない操作が行われました。"
      # 代理報告か否かでリダイレクト先を分岐
      if proxy_report_check
        return redirect_to teachers_charger_alergy_checks_url
      else
        return redirect_to teachers_alergy_checks_url
      end
    end

    #バリデーションチェック前の値セット
    @alergy_check.assign_attributes(today_check_params)

    if @alergy_check.valid?(:today_check) && @alergy_check.save
      flash[:success] = "#{@alergy_check.student.student_name}のチェックを報告しました。"
    else
      flash[:danger] = "#{@alergy_check.student.student_name}のチェック報告に失敗しました。<br>" + "・" + @alergy_check.errors.full_messages.join("<br>・")
    end
    # 代理報告か否かでリダイレクト先を分岐
    if proxy_report_check
      redirect_to teachers_charger_alergy_checks_url
    else
      redirect_to teachers_alergy_checks_url
    end
  end

  def one_month_index
    # 日付と児童のid順でデータを取得
    @alergy_checks = @classroom.alergy_checks.where(worked_on: @first_day..@last_day).order(:worked_on, student_id: :asc)
  end

  private
    # 代理報告か確認
    def proxy_report_check
      !!params[:proxy_flag] || params[:alergy_check][:proxy_flag]
    end

    def set_classroom
      if params[:select_classroom]
        @classroom = Classroom.find(params[:select_classroom])
      else
        @classroom = current_teacher.classroom
      end
    end

    # クラスを持つ職員かどうかの判定
    def have_class_room?
      unless Classroom.exists?(current_teacher.classroom_id)
        flash[:danger] = "許可されていない操作です。"
        redirect_to show_teachers_path
      end
    end

    # 自クラス報告用
    def today_check_params
      # .merge〜でパラメータに報告者名とステータスを追加
      params.require(:alergy_check).permit(:first_check, :second_check, :student_check).merge(applicant: current_teacher.teacher_name, status: "報告中")
    end
end
