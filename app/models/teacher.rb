class Teacher < ApplicationRecord
  belongs_to :school
  belongs_to :classroom
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_TCODE_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :tcode, presence: true, length: { in: 4..6 },
              format: { with: VALID_TCODE_REGEX, message: 'は半角・英数を両方含む必要があります' },
              uniqueness: true  
end
