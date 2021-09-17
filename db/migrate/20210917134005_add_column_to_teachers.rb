class AddColumnToTeachers < ActiveRecord::Migration[5.1]
  def change
    add_column :teachers, :teacher_name, :string, null: false, default: ""
    add_column :teachers, :admin, :boolean, null: false, default: false
    add_column :teachers, :creator, :boolean, null: false, default: false
  end
end
