class MenusController < ApplicationController
  include SchoolsHelper

  before_action :set_school
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :admin_teacher, only: [:new, :create, :edit, :update, :destroy]


  def index
    @menus = @school.menus.all.order(created_at: :desc)
  end

  # 献立表詳細
  def show
  end

  # 献立表追加
  def new
    @menu = @school.menus.new
  end

  # 献立表保存
  def create
    @menu = @school.menus.new(menu_params)
    if @menu.save
      flash[:success] = '献立表を追加しました。'
      redirect_to teachers_menu_path(@menu) and return
    else
      respond_to do |format|
        format.js { flash.now[:danger] = "作成に失敗しました。<br>・#{@menu.errors.full_messages.join('<br>・')}"} 
        format.js { render 'new' }
      end
    end
  end

  # 献立編集
  def edit
  end

  # 献立表更新
  def update
    if @menu.update_attributes(menu_params)
      flash[:success] = "献立表を更新しました。"
      redirect_to teachers_menu_path(@menu) and return
    else
      respond_to do |format|
        format.js { flash.now[:danger] = "更新に失敗しました。<br>・#{@menu.errors.full_messages.join('<br>・')}"} 
        format.js { render 'edit' }
      end
    end
  end

  # 献立表削除
  def destroy
    @menu.destroy
    flash[:success] = "#{@menu.menu_name}を削除しました。"
    redirect_to teachers_menus_path
  end

  private

      # schoolの特定
      def set_school
        @school = current_school
      end

      # menuの特定
      def set_menu
        @menu = @school.menus.find(params[:id])
      end

      def menu_params
        params.require(:menu).permit(:menu_name, :menu_pdf, :school_id)
      end

end
