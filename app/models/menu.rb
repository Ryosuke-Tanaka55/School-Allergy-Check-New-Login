class Menu < ApplicationRecord
  belongs_to :school
  mount_uploader :menu_pdf, PdfUploader

  validates :menu_name, presence: true
  validates :menu_pdf, presence: true
end
