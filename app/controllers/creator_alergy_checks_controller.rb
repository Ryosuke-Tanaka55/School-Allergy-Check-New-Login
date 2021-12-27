class CreatorAlergyChecksController < ApplicationController
  before_action :system_admin_inaccessible
  before_action :creator_teacher
  before_action :set_first_last_day, only: :index

  def index
    @one_month = [*@first_day..@last_day]
    @students = Student.where(school_id: current_teacher.school_id)
  end

  def new
    @student = Student.new
    @alergy_check = @student.alergy_checks.build
    @day = params[:day].to_date
    @classrooms = current_teacher.school.classrooms.where(using_class: true)
  end

  def create
    AlergyCheck.transaction do
      params[:student][:alergy_checks_attributes].each do |_, v|
        student = current_teacher.school.students.find(v[:student_id])
        if v[:_destroy] == "false"
          student.alergy_checks.create!(
            worked_on:  v[:worked_on],
            menu:       v[:menu],
            support:    v[:support],
            note:       v[:note]
          )
        end
      end
    end
    flash[:success] = '対応法を登録しました。'
    redirect_to teachers_creator_alergy_checks_url

  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
    respond_to do |format|
      # エラーメッセージをうまく取り出せない為、詳しいエラー内容表示ができていない
      format.js { flash.now[:danger] = "登録に失敗しました。入力内容に不備がないか確認してください。" }
      format.js { render 'new' }
    end
  end

  def edit
    @alergy_check = AlergyCheck.find(params[:id])
    @student = @alergy_check.student
    @classroom = current_teacher.school.classrooms.find(@student.classroom_id)
    @classrooms = current_teacher.school.classrooms.where(using_class: true)
  end

  def update
    if params[:alergy_check][:student_id].present?
      @alergy_check = AlergyCheck.find(params[:id])
      if @alergy_check.update(edit_creator_params)
        flash[:success] = "#{l(@alergy_check.worked_on, format: :short)}の情報を更新しました。"
      else
        respond_to do |format|
          format.js { flash.now[:danger] = "更新に失敗しました。<br>・#{@alergy_check.errors.full_messages.join('<br>・')}"} 
          format.js { render 'edit' }
        end
      end
    elsif params[:alergy_check][:student_id].nil?
      respond_to do |format|
        format.js { flash.now[:danger] = "登録に失敗しました。児童の情報が存在しません。入力内容を確認してください。"} 
        format.js { render 'edit' }
      end
    else
      respond_to do |format|
        format.js { flash.now[:danger] = "登録に失敗しました。児童名を選択してください。"} 
        format.js { render 'edit' }
      end
    end
  end

  def destroy
    @alergy_check = AlergyCheck.find(params[:id])
    @student = @alergy_check.student
    @alergy_check.destroy
    flash[:success] = "#{l(@alergy_check.worked_on, format: :short)}、#{@student.student_name}の対応法を削除しました。"
    redirect_to teachers_creator_alergy_checks_url
  end

  def search_student
    students = current_teacher.school.classrooms.find_by(id: params[:classroom_id]).students
    response = students.map{|student| [student.id, student.student_name]}
    render json: response
  end

  private
    def edit_creator_params
      params.require(:alergy_check).permit(:student_id, :menu, :support, :note)
    end

    # 対応法作成権限を持つ職員かどうかの判定
    def creator_teacher
      unless current_teacher.creator? || current_teacher.admin?
        flash[:danger] = "アクセス権限がありません。"
        redirect_to show_teachers_path
      end
    end
end