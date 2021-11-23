class AddApplicantToAlergycheck < ActiveRecord::Migration[5.1]
  def change
    add_column :alergy_checks, :applicant_id, :integer
  end
end
