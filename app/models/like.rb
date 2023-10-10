class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post'

  after_save :update_likes

  private

  def update_likes
    post.increment!(:like_counter)
  end
end
