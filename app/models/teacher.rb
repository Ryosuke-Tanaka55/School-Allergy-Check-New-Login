class Teacher < ApplicationRecord
  belongs_to :school
  belongs_to :classroom, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable,
         authentication_keys: %i[tcode]
        #  strip_whitespace_keys: %i[email]

  validates :teacher_name,  presence: true, length: { maximum: 50 }

  VALID_TCODE_REGEX = /\A(?=.*?[a-zA-Z])(?=.*?[\d])[a-zA-Z\d]+\z/i.freeze
  validates :tcode, presence: true, length: { in: 4..8 },
              format: { with: VALID_TCODE_REGEX, message: 'は半角・英数を両方含む必要があります' },
              uniqueness: true


  # email_required?の返り値をfalseにする事で、emailのvalidates_presence_ofのバリデーションを行わない
  def email_required?
    !email.blank? && super
  end

  private

  # 学校管理者の場合はメール有、その他職員の場合はメール無でOKの設定
  def validate_email
    if self.admin?
      if Teacher.find_by(email: self.email)
        errors.add(:email, "は重複しています。")
      end
    end
  end

end
