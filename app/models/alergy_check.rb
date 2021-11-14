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
end
