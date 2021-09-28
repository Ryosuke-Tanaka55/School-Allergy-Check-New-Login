class AddBasicInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :basic_time
    add_column :users, :work_time
  end
end
