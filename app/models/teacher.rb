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

  # # [Devise] 全ての認証時にユーザーを特定する
  # # ログイン・パスワードリセット・それ以外で認証条件を分ける
  # def self.find_first_by_auth_conditions(warden_condition)
  #   if login?(warden_condition)
  #     school = School.find_by(school_url: warden_condition[:current_school_url])
  #     school.teachers.find_by(tcode: warden_condition[:tcode])
  #   else
  #     # token利用時
  #     super(warden_condition)
  #   end
  # end

  validates :teacher_name,  presence: true, length: { maximum: 50 }

  VALID_TCODE_REGEX = /\A(?=.*?[a-zA-Z])(?=.*?[\d])[a-zA-Z\d]+\z/i.freeze
  validates :tcode, presence: true, length: { in: 4..8 },
              format: { with: VALID_TCODE_REGEX, message: 'は半角・英数を両方含む必要があります' },
              uniqueness: true

  # validates :email, uniqueness: true

  # email_required?の返り値をfalseにする事で、emailのvalidates_presence_ofのバリデーションを行わない
  def email_required?
    !email.blank? && super
  end

  # # データ更新・変更時にemailを必須としない設定
  # def email_required?
  #   false
  # end

  # def email_changed?
  #   false
  # end

  # attributes
  # アクセス中のスクールコード=URLに含まれるschool_codeをセット
  # attr_accessor :current_school_url

end
