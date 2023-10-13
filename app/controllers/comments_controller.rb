class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.user_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
    else
      render :new, alert: 'An error has occurred while creating the comment'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @post.decrement!(:comment_counter)
    @comment.destroy!
    redirect_to user_post_path(author_id: @post.author_id, id: @post.id), notice: 'Comment successfully deleted'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
