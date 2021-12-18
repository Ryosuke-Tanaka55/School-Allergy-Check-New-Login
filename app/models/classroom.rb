class Classroom < ApplicationRecord
  belongs_to :school
  has_many :teachers, dependent: :destroy
  has_many :students, dependent: :destroy
  accepts_nested_attributes_for :students, allow_destroy: true
  has_many :alergy_checks, through: :students

  #森本検証用のため
  scope :joins_get_all_columns, ->(*tables) {
    joins(*tables).select("*")
  }
end
