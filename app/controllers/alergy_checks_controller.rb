class AlergyChecksController < ApplicationController
  def new
    @alergy_check = AlergyCheck.new
    @day = params[:day].to_date
    @classrooms = Classroom.all
  end

  def create
    student = Student.find(params[:alergy_check][:student_id].to_i)
    if student.present?
      @alergy_check = AlergyCheck.new(alergy_menu_params)
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
  end

  def update
  end

  def destroy
  end

  private
    def alergy_menu_params
      params.require(:alergy_check).permit(:worked_on, :student_id, :menu, :support, :note)
    end
end
