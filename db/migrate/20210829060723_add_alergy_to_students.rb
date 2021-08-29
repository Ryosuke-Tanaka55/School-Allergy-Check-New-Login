class AddAlergyToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :alergy, :string
  end
end
