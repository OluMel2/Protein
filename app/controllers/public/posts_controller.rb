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
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end


  private

  def post_params
    params.require(:post).permit(:product_name, :tast, :price, :net, :serving_size, :calorie, :protein, :description, :image)
  end

end
