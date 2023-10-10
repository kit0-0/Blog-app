require 'rails_helper'

RSpec.describe 'Post show' do
  before :each do
    @user = User.create(name: 'John Doe', photo: 'https://example.com/john-doe.jpg', bio: 'Web Developer',
                        post_counter: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Rails Journey', text: 'Exploring the world of Rails development.',
                         like_counter: 0, comment_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Hello World', text: 'Another day, another hello.',
                         like_counter: 0, comment_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Ruby Adventures', text: 'Discovering the beauty.',
                         like_counter: 0, comment_counter: 0)
    @comment1 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'Great post!')
    @comment2 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'I learned a lot.')
    @like = Like.create(user_id: @user.id, post_id: @post1.id)
    visit user_post_path(@user.id, @post1.id)
  end

  it 'see the post title' do
    expect(page).to have_content('Rails Journey')
  end

  it 'see who wrote the post' do
    expect(page).to have_content('John Doe')
  end

  it 'see how many comments it has' do
    expect(page).to have_content('Comments: 2')
  end

  it 'see how many likes it has' do
    expect(page).to have_content('Likes: 1')
  end

  it 'see the post body' do
    expect(page).to have_content('Exploring the world of Rails development.')
  end

  it 'see the username of each commentator' do
    expect(page).to have_content(@comment1.author.name)
    expect(page).to have_content(@comment2.author.name)
  end

  it 'see the comment of each commentator left' do
    expect(page).to have_content('Great post!')
    expect(page).to have_content('I learned a lot.')
  end
end
