class ChangeApplicantIdToAlergyCheck < ActiveRecord::Migration[5.1]
  def change
    rename_column :alergy_checks, :applicant_id, :applicant
  end
end
