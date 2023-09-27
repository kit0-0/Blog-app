require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Alice') }
  let(:post) { user.posts.create(title: 'Sample Post') }

  describe 'validations' do
    it 'should be valid with valid attributes' do
      comment = post.comments.build(author: user)
      expect(comment).to be_valid
    end

    it 'should not be valid without an author' do
      comment = post.comments.build(author: nil)
      expect(comment).to_not be_valid
    end
  end

  describe 'after_save callback' do
    it 'increments post\'s comments_counter after saving' do
      expect do
        post.comments.create(author: user)
      end.to change { post.reload.comments_counter }.by(1)
    end
  end
end
