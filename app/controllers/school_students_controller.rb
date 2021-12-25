class SchoolStudentsController < ApplicationController
  include SchoolsHelper

  before_action :system_admin_inaccessible
  before_action :set_school
  before_action :set_school_student, only: [:edit, :update, :destroy]
  before_action :admin_teacher, only: [:new, :create, :edit, :update, :destroy]

  # 児童一覧
  def index
    @school_students = @school.students.all.order(:classroom_id, student_number: :asc)
  end

  # 児童追加モーダル表示
  def new
    @school_student = @school.students.new
    @classrooms = current_teacher.school.classrooms.where(using_class: true)
  end

  # 児童追加モーダル更新
  def create
    @school_student = @school.students.new(student_params)
    if @school_student.save
      flash[:success] = '児童を追加しました。'
      redirect_to teachers_school_students_path and return
    else
      flash[:danger] = "追加に失敗しました。<br>・#{@school_student.errors.full_messages.join('<br>・')}"
    end
    redirect_to teachers_school_students_path and return
  end

  def show
  end
  
  # 児童編集モーダル表示
  def edit
    @classrooms = current_teacher.school.classrooms.where(using_class: true)
  end

  # 児童編集モーダル更新
  def update
    if @school_student.update_attributes(student_params)
      flash[:success] = "児童情報を更新しました。"
      redirect_to teachers_school_students_path and return
    else
      flash[:danger] = "更新に失敗しました。<br>・#{@school_student.errors.full_messages.join('<br>・')}"
  end
  redirect_to teachers_school_students_path and return
  end
  
  # 児童削除
  def destroy
    @school_student.destroy
    flash[:success] = "#{@school_student.student_name}を削除しました。"
    redirect_to teachers_school_students_path
  end

  private

      # schoolの特定
      def set_school
        @school = current_school
      end

      # 児童の特定
      def set_school_student
        @school_student = @school.students.find(params[:id])
      end

      def student_params
        params.require(:student).permit(:student_number, :student_name, :alergy, :student_note, :classroom_id)
      end

end
