class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
       render "edit"
    else
       redirect_to user_mypage_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_mypage_path(@user.id)
  end


  def out
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    #flash[:notice] = "またのご利用をお待ちしております。"
    redirect_to root_path
  end
end



private

def user_params
  params.require(:user).permit(:name, :image, :introduction, :work_out)
end