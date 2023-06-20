class Public::PostsController < ApplicationController
  before_action :authenticate_user!


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      #@post.save! バリデーションで不具合が出たため
      redirect_to posts_all_path
      flash[:notice] = '新規投稿されました。'
    else
      flash[:alert] = '投稿に失敗しました。'
      render :new
    end
  end

  def index
    @posts = Post.joins(:user).where("users.is_deleted = false").page(params[:page])
    #退会したユーザーのデータは表示されない。#@posts = Post.all
    if params[:tag_id].present?
      @posts = @posts.where(tag_id: params[:tag_id])
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render :edit
    else
      redirect_to user_mypage_path(current_user)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to user_mypage_path(current_user)
      flash[:notice] = '投稿の編集が完了しました。'
    else
      flash[:alert] = '必要な情報が入力されていません。'
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_mypage_path(current_user)
    flash[:alert] = '投稿を削除しました。'
  end

  private

  def post_params
    params.require(:post).permit(:product_name, :tast, :price, :net, :serving_size, :calorie, :protein, :description, :image, :tag_id)
  end


end
