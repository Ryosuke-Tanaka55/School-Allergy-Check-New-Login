module AlergyChecksHelper
  def check_state(status)
    if status == ""
      return "報告する"
    else
      return status
    end
  end
end
