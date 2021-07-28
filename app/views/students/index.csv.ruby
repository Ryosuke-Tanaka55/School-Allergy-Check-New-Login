require 'csv'


CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  column_names = (児童名 学級  担任  アレルギー食品)
  
  csv << column_names
  @students.each do |st|
    column_values = [
      st.student_classroom,
      st.teacher_of_student_of_teachr,
      st.student_name,
      st.alergy]
    
    csv << column_values
 
 end
end