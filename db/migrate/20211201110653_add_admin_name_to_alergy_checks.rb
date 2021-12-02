class AddAdminNameToAlergyChecks < ActiveRecord::Migration[5.1]
  def change
    add_column :alergy_checks, :admin_name, :string
  end
end
