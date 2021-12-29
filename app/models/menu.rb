class Menu < ApplicationRecord
  belongs_to :school
  mount_uploader :menu_pdf, PdfUploader

  validates :menu_name, presence: true, uniqueness: { scope: :school_id }
  validates :menu_pdf, presence: true
end
