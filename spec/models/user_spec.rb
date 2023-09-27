require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John') }

  before { subject.save }

  describe 'validation tests' do
    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be an integer' do
      subject.posts_counter = 'hey'
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be greater than or equal to zero' do
      subject.posts_counter = -2
      expect(subject).to_not be_valid
      subject.posts_counter = 0
      expect(subject).to be_valid
    end
  end

  describe '#recent_posts' do
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'Alice')
      post1 = Post.create(title: 'Post 1', author: user, created_at: 4.days.ago)
      post2 = Post.create(title: 'Post 2', author: user, created_at: 3.days.ago)
      post3 = Post.create(title: 'Post 3', author: user, created_at: 2.days.ago)
      rec_posts = user.recent_posts
      expect(rec_posts).to eq([post3, post2, post1])
    end
  end
end
