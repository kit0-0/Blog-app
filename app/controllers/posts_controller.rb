class PostsController < ApplicationController
  before_action :find_user, only: %i[index show like unlike]
  before_action :find_post, only: %i[show like unlike]

  def index
    @posts = @user.posts
  end

  def show; end

  def new
    @user = current_user
    @post = @user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Post created successfully.'
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def like
    @like = @post.likes.new(user: current_user)
    if @like.save
      redirect_to user_post_path(@user, @post), notice: 'Post liked successfully.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Failed to like the post.'
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @post = @user.posts.find_by(id: params[:id])
    return unless @post.nil?

    flash[:alert] = 'Post not found, back to posts page'
    redirect_to user_posts_path(@user)
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
