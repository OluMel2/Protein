class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
  if @post.update(post_params)
    redirect_to admin_post_path
  else
    render :edit
  end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_root_path
  end

  private

  def post_params
    params.require(:post).permit(:product_name, :tast, :price, :net, :serving_size, :calorie, :protein, :description, :image)
  end

end
