class AddCreatorColumnToAlergycheck < ActiveRecord::Migration[5.1]
  def change
    add_column :alergy_checks, :menu, :string
    add_column :alergy_checks, :support, :string
  end
end
