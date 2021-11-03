class AddNotnullCreatorToAlergyCheck < ActiveRecord::Migration[5.1]
  def change
    change_column :alergy_checks, :menu, :string, null: false
    change_column :alergy_checks, :support, :string, null: false
  end
end
