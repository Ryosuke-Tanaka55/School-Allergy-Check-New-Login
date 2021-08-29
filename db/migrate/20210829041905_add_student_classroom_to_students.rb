class AddStudentClassroomToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :student_classroom, :string
  end
end
