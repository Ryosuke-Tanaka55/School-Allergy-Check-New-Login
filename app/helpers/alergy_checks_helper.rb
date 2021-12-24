module AlergyChecksHelper
  # 未報告件数計算
  def unchecked(must_checked:, checked:)
    return must_checked - checked
  end

  # チェック児童一覧ページ、(全学級)月間チェック一覧ページステータス表示
  def check_state(status:, name:)
    case status
    when "" then
      return "未報告"
    when "報告中" then
      return "報告中"
    when "確認済"
      return "#{name} #{status}"
    end
  end

  # 備考欄空白の場合は「なし」表示」
  def note(note)
    if note.present?
      return note
    else
      return "なし"
    end
  end
end
