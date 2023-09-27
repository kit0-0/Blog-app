require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Test User') }

  describe 'validations' do
    it 'should be valid with valid attributes' do
      post = user.posts.build(title: 'Test Post')
      expect(post).to be_valid
    end

    it 'should not be valid without a title' do
      post = user.posts.build(title: nil)
      expect(post).to_not be_valid
    end

    it 'should not be valid with a title exceeding 250 characters' do
      long_title = 'a' * 251
      post = user.posts.build(title: long_title)
      expect(post).to_not be_valid
    end

    it 'should have a comments_counter greater than or equal to 0' do
      post = user.posts.build(title: 'Test Post', comments_counter: -1)
      expect(post).to_not be_valid
      post.comments_counter = 0
      expect(post).to be_valid
    end

    it 'should have a likes_counter greater than or equal to 0' do
      post = user.posts.build(title: 'Test Post', likes_counter: -1)
      expect(post).to_not be_valid
      post.likes_counter = 0
      expect(post).to be_valid
    end
  end

  describe '#recent_comments' do
    it 'returns the specified number of most recent comments' do
      post = user.posts.create(title: 'Test Post')
      post.comments.create(text: 'Comment 1', author: user)
      comment2 = post.comments.create(text: 'Comment 2', author: user)
      comment3 = post.comments.create(text: 'Comment 3', author: user)

      recent_comments = post.recent_comments(2)
      expect(recent_comments).to eq([comment3, comment2])
    end
  end

  describe 'after_save callback' do
    it 'increments author\'s posts_counter after saving' do
      expect do
        user.posts.create(title: 'Test Post')
      end.to change { user.reload.posts_counter }.by(1)
    end
  end
end
