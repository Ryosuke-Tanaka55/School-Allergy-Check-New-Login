class School < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :classrooms, dependent: :destroy
  has_many :students, dependent: :destroy
end
