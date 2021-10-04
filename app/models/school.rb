class School < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :classrooms, dependent: :destroy
  accepts_nested_attributes_for :classrooms
end
