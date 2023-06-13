class Public::UsersController < ApplicationController

  def show
    @user = User.find_by(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find_by(params[:id])
    if @user == current_user
       render "edit"
    else
       redirect_to user_mypage_path(current_user)
    end
  end

  def update
    @user = User.find_by(params[:id])
    @user.update(user_params)
    redirect_to user_mypage_path(@user.id)
  end
end


private

def user_params
  params.require(:user).permit(:name, :image, :introduction, :work_out)
end