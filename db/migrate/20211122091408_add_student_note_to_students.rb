class AddStudentNoteToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :student_note, :string
  end
end
