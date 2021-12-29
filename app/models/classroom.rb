class Classroom < ApplicationRecord
  belongs_to :school
  has_many :teachers, dependent: :destroy
  has_many :students, dependent: :destroy
  accepts_nested_attributes_for :students, allow_destroy: true
  has_many :alergy_checks, through: :students

  validates :class_name, presence: true, length: { maximum: 20 }, uniqueness: { scope: :school_id }

end
