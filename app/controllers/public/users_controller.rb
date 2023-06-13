class Public::UsersController < ApplicationController



  def show
    @user = User.find_by(params[:id])
    @posts = @user.posts
  end

  def edit
    
  end
end



private

def user_params
  params.require(:user).permit(:name, :image, :introduction, :work_out)
end