require 'rails_helper'

RSpec.describe 'User show', type: :feature do
  before :each do
    @user = User.create(name: 'John Doe', photo: 'https://example.com/john-doe.jpg', bio: 'Software Engineer',
                        post_counter: 0)
    @post1 = Post.create(author_id: @user.id, title: 'My First Post', text: 'This is the content of my first post.',
                         like_counter: 0, comment_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Rails Rocks', text: 'Excited about Rails development!',
                         like_counter: 0, comment_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Learning Ruby', text: 'Exploring the beauty of Ruby language.',
                         like_counter: 0, comment_counter: 0)
    visit user_path(@user.id)
  end

  it 'see the user profile picture' do
    expect(page).to have_css("img[src*='https://example.com/john-doe.jpg']")
  end

  it 'see the user profile name' do
    expect(page).to have_content 'John Doe'
  end

  it 'see the number of posts user has written' do
    expect(page).to have_content 'Number of posts: 3'
  end

  it 'see the user bio ' do
    expect(page).to have_content 'Software Engineer'
  end

  it 'see the user first three posts ' do
    expect(page).to have_content('This is the content of my first post.')
    expect(page).to have_content('Excited about Rails development!')
    expect(page).to have_content('Exploring the beauty of Ruby language.')
  end

  it 'see the button that lets me view all users posts' do
    expect(page).to have_link('See all posts')
  end

  it "When I click a user's post, it redirects me to that post's show page." do
    click_on 'My First Post'
    expect(page).to have_content 'This is the content of my first post.'
  end

  it " When I click to see all posts, it redirects me to the user's post's index page. " do
    click_on 'See all posts'
    expect(page).to have_content "John Doe's Posts"
  end
end
