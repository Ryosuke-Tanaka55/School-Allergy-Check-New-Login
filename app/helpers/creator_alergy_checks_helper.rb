module CreatorAlergyChecksHelper

  def create_alergy_check_button(day)
    if day < Date.today
      link_to "入力", "#", class: "btn btn-primary disabled-btn"
    else
      link_to "入力", new_teachers_creator_alergy_check_path(day: day), class: "btn btn-primary", remote: true
    end
  end

  def edit_alergy_check_button(alergy_check_id)
    alergy_check = AlergyCheck.find(alergy_check_id)
    if alergy_check.reported? || alergy_check.worked_on < Date.today
      link_to "編集", "#", class: "btn btn-primary disabled-btn"
    else
      link_to "編集", edit_teachers_creator_alergy_check_path(alergy_check.id), class: "btn btn-primary", remote: true
    end
  end

  def destroy_alergy_check_button(alergy_check_id)
    alergy_check = AlergyCheck.find(alergy_check_id)
    if alergy_check.reported? || alergy_check.worked_on < Date.today
      link_to "削除", "#", class: "btn btn-danger disabled-btn"
    else
      link_to "削除", teachers_creator_alergy_check_path(alergy_check.id), method: :delete,
        data: { confirm: "#{l(alergy_check.worked_on, format: :short)}、#{alergy_check.student_name}の対応法を削除します。よろしいですか？" },
        class: "btn btn-danger"
    end
  end
end
