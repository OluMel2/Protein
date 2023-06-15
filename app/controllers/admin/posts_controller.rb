class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = @post.comments
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
