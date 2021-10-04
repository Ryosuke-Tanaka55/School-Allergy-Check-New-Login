class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :school_name,  null: false, default: ""
      t.string :school_url,   null: false, default: ""

      t.timestamps
    end
  end
end
