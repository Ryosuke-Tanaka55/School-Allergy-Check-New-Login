class MenusController < ApplicationController
  include SchoolsHelper

  before_action :set_school

  def index
    @first_day = params[:date].nil? ? Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    @one_month = [*@first_day..@last_day]
    @menu = @school.menus.all
  end

  # 献立詳細
  def show
    @menu = @school.menus.find(params[:id])
  end

  # 献立アップロード
  def new
    @menu = @school.menus.new
  end

  # 献立保存
  def create
    debugger
    if params[:menu][:menu_pdf].blank?
      flash[:danger] = "ファイルを指定してください。"
      redirect_to teachers_menus_path
    else
      @menu = @school.menus.new(menu_params)
      if @menu.save
        flash[:success] = '新規投稿しました。'
        redirect_to teachers_menu_path(@menu)
      else
        render :new
      end
    end
  end

  # 献立編集
  def edit
  end

  # 献立更新
  def update
    if @menu.update_attributes(menu_params)
      flash[:success] = "更新しました。"
      redirect_to @menu
    else
      flash.now[:danger] = "#{@menu.errors.full_messages}" if @menu.errors.present?
      render :edit
    end
  end

  # スケジュール削除
  def destroy
    @menu.destroy
    flash[:success] = ""
    redirect_to "#"
  end

  private

      # schoolの特定
      def set_school
        @school = current_school
      end

      def menu_params
        params.require(:menu).permit(:menu_pdf, :school_id)
      end

end
