class Classroom < ApplicationRecord
  belongs_to :school
  has_many :teachers, dependent: :destroy
  has_many :students, dependent: :destroy
end
