module AlergyChecksHelper
  # 報告ボタンテキスト表示切り替え
  def check_state(status)
    if status == ""
      return "報告する"
    else
      return status
    end
  end

  # 月間チェック一覧ページステータス表示
  def monthly_check_state(status)
    case status
    when "" then
      return "未報告"
    when "報告中" then
      return "管理職へ#{status}"
    when "確認済"
      return "管理職#{status}"
    end
  end
end
