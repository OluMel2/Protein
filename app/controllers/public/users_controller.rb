class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_mypage_path(current_user)
      flash[:notice] = 'ユーザー情報を更新しました。'
    else
      flash[:alert] =  'ユーザー情報の更新に失敗しました。'
      render :edit
    end
  end


  def out
    @user = current_user
    @user.update(is_deleted: true)
    @user.comments.destroy_all
    reset_session
    flash[:alert] = 'またのご利用をお待ちしております。'
    redirect_to root_path
  end




private

def user_params
  params.require(:user).permit(:name, :profile_image, :introduction, :work_out)
end

#文字列になので、to_s。paramsと合わせる
def ensure_user
  unless current_user.id.to_s == params[:id]
    redirect_to posts_all_path
    flash[:alert] = '他のユーザーのプロフィール編集画面には遷移できません。'
  end
end


def ensure_guest_user
  @user = User.find(params[:id])
  if @user.name == "guestuser"
    redirect_to posts_all_path
    flash[:alert] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
  end
end



end