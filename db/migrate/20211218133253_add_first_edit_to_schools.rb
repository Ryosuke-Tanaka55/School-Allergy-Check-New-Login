class AddFirstEditToSchools < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :first_edit, :boolean, default: false, null: false
  end
end
