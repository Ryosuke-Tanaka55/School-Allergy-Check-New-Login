module AlergyChecksHelper
  # 報告ボタンテキスト表示
  def check_state(status)
    case status
    when "" then
      return "報告する"
    else
      return status
    end
  end

  # 月間チェック一覧ページステータス表示
  def monthly_check_state(status:, name:)
    case status
    when "" then
      return "未報告"
    when "報告中" then
      return "#{name}へ#{status}"
    when "確認済"
      return "#{name} #{status}"
    end
  end

  # 備考欄表示有無
  def note(note)
    if note.present?
      return note
    else
      return "なし"
    end
  end
end
