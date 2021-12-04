module SchoolsHelper
  def current_school
    if current_teacher
      current_teacher.school
    else
      nil
    end
  end
end
