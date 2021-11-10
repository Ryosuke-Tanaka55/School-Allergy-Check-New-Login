class School < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :classrooms, dependent: :destroy
  has_many :students, dependent: :destroy
  accepts_nested_attributes_for :classrooms

  VALID_SCHOOLURL_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :school_url, presence: true, length: { in: 5..7 },
              format: { with: VALID_SCHOOLURL_REGEX, message: 'は半角・英数を両方含む必要があります' },
              uniqueness: true

  validates :school_name,  presence: true, length: { maximum: 30 }, uniqueness: true

  def to_param
    school_url
  end
end
