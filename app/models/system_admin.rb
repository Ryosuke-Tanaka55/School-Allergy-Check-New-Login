class SystemAdmin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 3 }, allow_nil: true
end
