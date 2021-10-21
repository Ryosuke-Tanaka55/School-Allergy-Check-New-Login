class AlergyChecks::CreatorsController < ApplicationController
  def new
    @alergy_check = AlergyCheck.new
    @day = params[:day].to_date
    @classrooms = Classroom.all
  end

  def create
    if @student = Student.find(params[:alergy_check][:student_id].to_i)
      @alergy_check = @student.alergy_checks.new(new_alergy_menu_params)
      if @alergy_check.save
        flash[:success] = "献立情報を登録しました。"
      else
        flash[:danger] = "登録に失敗しました。"
      end
    else
      flash[:danger] = "児童の情報が存在しません。入力内容を確認してください。"
    end
    redirect_to creator_teachers_url
  end

  def edit
    @student = Student.find(params[:student_id])
    @alergy_check = AlergyCheck.find(params[:id])
  end

  def update
    @student = Student.find(params[:student_id])
    @alergy_check = AlergyCheck.find(params[:id])
    if @alergy_check.update(edit_alergy_menu_params)
      flash[:success] = "#{l(@alergy_check.worked_on, format: :short)}、#{@student.student_name}の情報を更新しました。"
    else
      flash[:danger] = "更新に失敗しました。<br>" + @aleryg_check.errors.full_messages.join("<br>")
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
    def new_alergy_menu_params
      params.require(:alergy_check).permit(:worked_on, :student_id, :menu, :support, :note)
    end

    def edit_alergy_menu_params
      params.require(:alergy_check).permit(:menu, :support, :note)
    end
end
