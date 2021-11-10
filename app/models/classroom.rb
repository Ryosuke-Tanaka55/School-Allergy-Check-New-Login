class Classroom < ApplicationRecord
  belongs_to :school
  has_many :teachers, dependent: :destroy
  has_many :students, dependent: :destroy
  accepts_nested_attributes_for :students, allow_destroy: true
end
