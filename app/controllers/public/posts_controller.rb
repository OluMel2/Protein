class Public::PostsController < ApplicationController



  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    # for DEBUG
    @post.tag_id = 0
    # for DEBUG

    @post.save!
    redirect_to posts_all_path
  end

  def index
    @posts = Post.joins(:user).where("users.is_deleted = false")
    #退会したユーザーのデータは表示されない。#@posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render "edit"
    else
      redirect_to posts_all_path
    end
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to posts_all_path
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_all_path
  end

  private

  def post_params
    params.require(:post).permit(:product_name, :tast, :price, :net, :serving_size, :calorie, :protein, :description, :image)
  end

end
