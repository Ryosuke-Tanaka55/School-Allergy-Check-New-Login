class AlergyChecks::CreatorsController < ApplicationController

  $days_of_the_week = %w{日 月 火 水 木 金 土}

  def new
    @student = Student.new
    @alergy_check = @student.alergy_checks.build
    @day = params[:day].to_date
    @classrooms = Classroom.all
  end

  def create
    if params[:alergy_check][:student_id].present?
      @student = Student.find(params[:alergy_check][:student_id].to_i)
      @alergy_check = @student.alergy_checks.new(new_creator_params)
      if @alergy_check.save
        flash[:success] = "献立情報を登録しました。"
      else
        flash[:danger] = "登録に失敗しました。<br>" + "・" + @alergy_check.errors.full_messages.join("<br>")
      end
    elsif params[:alergy_check][:student_id].nil?
      flash[:danger] = "登録に失敗しました。児童の情報が存在しません。入力内容を確認してください。"
    else
      flash[:danger] = "登録に失敗しました。クラス名と児童名を選択してください。"
    end
    redirect_to creator_teachers_url
  end

  def edit
    @student = Student.find(params[:student_id])
    @classroom = Classroom.find(@student.classroom_id)
    @alergy_check = AlergyCheck.find(params[:id])
    @classrooms = Classroom.all
  end

  def update
    if params[:alergy_check][:student_id].present?
      @student = Student.find(params[:student_id])
      @alergy_check = AlergyCheck.find(params[:id])
      if @alergy_check.update(edit_creator_params)
        flash[:success] = "#{l(@alergy_check.worked_on, format: :short)}の情報を更新しました。"
      else
        flash[:danger] = "更新に失敗しました。<br>" + "・" + @alergy_check.errors.full_messages.join("<br>")
      end
    elsif params[:alergy_check][:student_id].nil?
      flash[:danger] = "登録に失敗しました。児童の情報が存在しません。入力内容を確認してください。"
    else
      flash[:danger] = "登録に失敗しました。児童名を選択してください。"
    end
    redirect_to creator_teachers_url
  end

  def destroy
    @student = Student.find(params[:student_id])
    @alergy_check = AlergyCheck.find(params[:id])
    @alergy_check.destroy
    flash[:success] = "#{l(@alergy_check.worked_on, format: :short)}、#{@student.student_name}の情報を削除しました。"
    redirect_to creator_teachers_url
  end

  private
    def new_creator_params
      params.require(:alergy_check).permit(
        :student_id, alergy_checks_attributes: [:id, :worked_on, :menu, :support, :note, :_destroy])
    end

    def edit_creator_params
      params.require(:alergy_check).permit(:student_id, :menu, :support, :note)
    end
end
