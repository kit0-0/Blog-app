class Api::V1::PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @posts = Post.all.order('created_at')
    render json: { success: true, data: { posts: @posts } }, status: :ok
  end
end
