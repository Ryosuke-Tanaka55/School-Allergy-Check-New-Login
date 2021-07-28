class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update,:destroy]
  
  # GET /students or /students.json
  def import
    # fileはtmpに自動で一時保存される
     if params[:csv_file] .blank?
      flash[:danger]= "csvファイルを選択してください"
      redirect_to students_url
     else    
      Student.import(params[:csv_file])
      flash[:success]= "インポートしました"
      redirect_to students_url
     end  
  end
 
 
  def index
    @students = Student.all
    # csv出力
    respond_to do |format|
      format.html 
      format.csv do
        send_data render_to_string, filename: "アレルギーチェック.csv", type: :csv    #csv用の処理を書く
      end
    end  
  end
  
  def new
    @student = Student.new
  end

  # GET /positions/1/edit
  def edit
     @student = Student.find(params[:id])
  end

  # POST /positions
  # POST /positions.json
  def create
    @student = Student.new(student_params)
     if @student.save
       flash[:success] = '作成に成功しました。'
       redirect_to students_url
     else
      flash[:danger] = "アレルギー情報追加に失敗しました。"
      redirect_to students_url   
     end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(student_params)
       flash[:success] = "アレルギー情報を更新しました。"# 更新に成功した場合の処理を記述します。
       redirect_to students_url
    else
      flash[:danger] = "アレルギー追加に失敗しました。"
      redirect_to students_url
    end
  end 
  
  def destroy
    @student.destroy
    flash[:success] = "アレルギー情報を削除しました。"
    redirect_to students_url
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
       params.require(:student).permit( :student_id, :student_classroom, :teacher_of_student, :student_name, :alergy )
    end
end
