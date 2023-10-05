class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @three_recent_posts = @user.three_most_recent_posts
  end

  def new; end

  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'User not found, back to users page'
    redirect_to users_path
  end
end
