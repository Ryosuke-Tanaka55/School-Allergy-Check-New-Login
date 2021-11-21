class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.string :menu_name
      t.string :menu_pdf
      t.references :school, index: true, foreign_key: true

      t.timestamps
    end
  end
end
