class ChangeEmailDefault < ActiveRecord::Migration[5.1]
  def up
    change_column :teachers, :email, :string, null: true
    change_column_default :teachers, :email, nil
  end

  def down
    change_column :teachers, :email, :string, null: false
    change_column_default :teachers, :email, ""
  end
end
