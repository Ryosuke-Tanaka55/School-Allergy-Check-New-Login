class AlergyCheck < ApplicationRecord
  belongs_to :student
  has_one :classroom, through: :student

  # 登録時に使用する仮想カラム(DB保存不可)
  attribute :classroom, :integer
  attribute :student, :integer

  validates :worked_on, presence: true, null: false
  validates :note, length: { maximum: 50 }
  validates :menu, presence: true, length: { maximum: 20 }, null: false
  validates :support, presence: true, null: false

  # （想定先：管理者の報告確認モーダル）未チェックだが、報告状態が「確認済」のときは無効
  #validate :status_checker_need
  # （想定先：管理者の報告確認モーダル）チェック済みだが、報告状態が「報告中」のときは無効
  #validate :status_need

  def status_checker_need
    errors.add(:status, "チェックが必要です") if status_checker == "0" && status = "確認済" && worked_on = Date.today
  end

  def status_need
    errors.add(:status_checker, "報告状態の選択が正しくありません") if status_checker == "1" && status = "報告中" && applicant.present?
  end

  # 児童アレルギーチェック報告時、第1、第2、児童のチェックなしと報告者名なしは不可
  CHECK_ERROR_MSG = "が必要です"
  with_options on: :today_check do
    with_options acceptance: { message: CHECK_ERROR_MSG } do
      validates :first_check
      validates :second_check
      validates :student_check
    end
    validates :applicant, presence: true
  end

  # worked_onカラムが本日の日付であるものを取得する
  scope :today, -> { where(worked_on: Date.current) }
end