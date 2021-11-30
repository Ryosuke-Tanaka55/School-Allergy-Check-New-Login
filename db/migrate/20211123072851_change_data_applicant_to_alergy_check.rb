class ChangeDataApplicantToAlergyCheck < ActiveRecord::Migration[5.1]
  def change
    change_column :alergy_checks, :applicant, :string
  end
end
