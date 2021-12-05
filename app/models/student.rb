class Student < ApplicationRecord
  belongs_to :classroom
  belongs_to :school
  has_many :alergy_checks, dependent: :destroy
  accepts_nested_attributes_for :alergy_checks, allow_destroy: true

  validates :student_name,  presence: true
  validates :student_number,  presence: true

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
  #     #IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
  #     student = find_by(id: row["id"]) || new
  #     #CSVからデータを取得し、設定する
  #     student.attributes = row.to_hash.slice(*updatable_attributes)
  #     #保存する
  #     student.save
  #   end
  # end

  # # 更新を許可するカラムを定義
  # def self.updatable_attributes
  #   ["student_id", "student_classroom", "teacher_of_student", "student_name", "alegy" ]
  # end
end
