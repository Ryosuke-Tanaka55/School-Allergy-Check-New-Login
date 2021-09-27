class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :student_name,  null: false, default: ""
      t.integer :student_number,  null: false, unique: true
      # t.string :alergy

      t.references :school, index: true, foreign_key: true
      t.references :classroom, index: true, foreign_key: true

      t.timestamps
    end
  end
end
