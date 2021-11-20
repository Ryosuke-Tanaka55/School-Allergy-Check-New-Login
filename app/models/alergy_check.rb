class AlergyCheck < ApplicationRecord
  belongs_to :student
  has_one :classroom, through: :student

  # 登録時に使用する仮想カラム(DB保存不可)
  attribute :classroom, :integer
  attribute :student, :integer

  validates :worked_on, presence: true, null: false
  validates :note, length: { maximum: 50 }
  validates :menu, presence: true, length: { maximum: 20 }, null: false
  validates :support, presence: true, null: false

  CHECK_ERROR_MSG = "が必要です"
  # 児童アレルギーチェック報告時、それぞれのチェックなしと報告者名なしは不可
  with_options on: :today_check do
    with_options acceptance: { message: CHECK_ERROR_MSG } do
      validates :first_check
      validates :second_check
      validates :student_check
    end
    validates :applicant_id, presence: true
  end
end
