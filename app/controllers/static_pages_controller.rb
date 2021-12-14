class StaticPagesController < ApplicationController
  before_action :teacher_not_show

  def top
  end



  private
    # 職員がシステム管理者TOPページに遷移できないようにする
    def teacher_not_show
      if teacher_signed_in?
        flash[:danger] = "表示権限がありません。"
        redirect_to show_teachers_path
      end
    end


end
