class Menu < ApplicationRecord
  belongs_to :school
  mount_uploader :menu_pdf, PdfUploader
end
