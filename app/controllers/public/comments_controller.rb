class Public::CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
  if comment.save
    redirect_to post_path(post)
    flash[:notice] = 'コメントを投稿しました。'
  else
    flash[:alert] = 'コメントを投稿できませんでした。'
    redirect_to post_path(post)
  end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
    flash[:alert] = 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end