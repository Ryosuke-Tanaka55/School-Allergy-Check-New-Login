class CreateClassrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :classrooms do |t|
      t.string :class_name,   null: false, default: ""
      t.references :school, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
