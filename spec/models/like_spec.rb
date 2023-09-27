require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Alice') }
  let(:post) { user.posts.create(title: 'Sample Post') }

  describe 'validations' do
    it 'should be valid with valid attributes' do
      like = Like.create(user:, post_id: post.id)
      expect(like).to be_valid
    end
  end

  describe 'after_save callback' do
    it 'increments post\'s likes_counter after saving' do
      expect do
        Like.create(user:, post_id: post.id)
      end.to change { post.reload.likes_counter }.by(1)
    end
  end
end
