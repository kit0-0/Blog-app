class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @count = @post.comment_counter
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to user_posts_path(id: current_user.id)
    else
      render :new, alert: 'Cannot create a new post'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
