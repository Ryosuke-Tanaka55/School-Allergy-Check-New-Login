class CreateAdminAlergyChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_alergy_checks do |t|
      t.string :name

      t.timestamps
    end
  end
end
