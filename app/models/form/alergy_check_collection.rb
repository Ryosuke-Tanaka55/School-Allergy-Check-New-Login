class Form::AlergyCheckCollection < Form::Base
  FORM_COUNT = 10 #ここで、作成したい登録フォームの数を指定
  attr_accessor :alergy_checks

  def initialize(attributes = {})
    super attributes
    self.alergy_checks = FORM_COUNT.times.map { AlergyCheck.new() } unless self.alergy_checks.present?
  end

  def alergy_checks_attributes=(attributes)
    self.alergy_checks = attributes.map { |_, v| AlergyCheck.new(v) }
  end

  def save
    AlergyCheck.transaction do
      self.alergy_checks.map do |alergy_check|
        if alergy_check.availability # ここでチェックボックスにチェックを入れている商品のみが保存される
          alergy_check.save
        end
      end
    end
      return true
    rescue => e
      return false
  end
end