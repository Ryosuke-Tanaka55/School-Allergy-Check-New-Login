class AddTeacherOfStudentToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :teacher_of_student, :string
  end
end
