class ChanceStatusDefaultToAlergycheck < ActiveRecord::Migration[5.1]
  def up
    change_column :alergy_checks, :status, :string, null: false, default: ""
  end

  def down
    change_column :alergy_checks, :status, :string
  end
end
