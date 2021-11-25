class AddDetailsToAdminAlergyChecks < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_alergy_checks, :worked_on, :date
    add_column :admin_alergy_checks, :started_at, :datetime
    add_column :admin_alergy_checks, :finished_at, :datetime
    add_column :admin_alergy_checks, :note, :string
    add_column :admin_alergy_checks, :status, :string, default: "f"
    add_column :admin_alergy_checks, :lunch_check_superior, :string
    add_column :admin_alergy_checks, :superior_checker, :boolean
  end
end
