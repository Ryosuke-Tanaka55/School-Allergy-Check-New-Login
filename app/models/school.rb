class School < ApplicationRecord
   has_many :users, dependent: :destroy 
   
   validates :school_name, presence: true, length: { maximum: 50 },
                                                 uniqueness: true
end
