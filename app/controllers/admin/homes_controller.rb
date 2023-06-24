class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @posts = Post.joins(:user).where("users.is_deleted = false").page(params[:page]).order(created_at: :desc)
    #退会したユーザーのデータは表示されない。
  end
end
