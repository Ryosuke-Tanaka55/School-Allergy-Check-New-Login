class CreateAlergyChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :alergy_checks do |t|
      t.date :worked_on,  null: false
      t.string :note
      t.boolean :first_check,   null: false, default: false # 担任チェック
      t.boolean :second_check,  null: false, default: false # 2人目チェック
      t.boolean :student_check, null: false, default: false # 児童チェック
      t.string :status
      t.string :status_checker
      t.references :student, index: true, foreign_key: true

      t.timestamps
    end
  end
end
