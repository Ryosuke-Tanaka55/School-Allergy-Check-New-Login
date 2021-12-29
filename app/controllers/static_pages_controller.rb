class StaticPagesController < ApplicationController
  before_action :teacher_not_show, only: [:top]
  before_action :alert_not_show, only: [:alert]

  def top
  end

  def alert
  end

  private
    # 職員がシステム管理者TOPページに遷移できないようにする
    def teacher_not_show
      if teacher_signed_in?
        flash[:danger] = "表示権限がありません。"
        redirect_to show_teachers_path
      end
    end

    # 職員がログインしている間、アラートページは表示されない
    def alert_not_show
      if current_teacher
        redirect_to show_teachers_path
      end
    end
end
