class RemoveIndexEmailFromTeachers < ActiveRecord::Migration[5.1]
  def up
    remove_index :teachers, :email
  end

  def down
    add_index :teachers, :email, unique: true
  end
end
