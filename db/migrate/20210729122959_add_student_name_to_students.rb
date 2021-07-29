class AddStudentNameToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :student_name, :string
  end
end
