class AlergyCheck < ApplicationRecord
  validates :worked_on, presence: true, null: false
  validates :note, length: { maximum: 50 }
  validates :menu, presence: true, length: { maximum: 20 }, null: false
  validates :support, presence: true, null: false
end
