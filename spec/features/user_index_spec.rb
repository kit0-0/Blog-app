require 'rails_helper'

RSpec.describe 'User index', type: :feature do
  before :each do
    @user1 = User.create(name: 'John Doe', photo: 'https://example.com/john-doe.jpg', bio: 'Software Engineer',
                         post_counter: 5)
    @user2 = User.create(name: 'Jane Smith', photo: 'https://example.com/jane-smith.jpg', bio: 'UX Designer',
                         post_counter: 3)
    visit root_path
  end

  it 'shows the correct content' do
    expect(page).to have_content('Explore Our Community')
  end

  it 'shows the number of posts each user has written' do
    expect(page).to have_content('Number of posts')
    expect(page).to have_text("John Doe\nNumber of posts: 5")
    expect(page).to have_text("Jane Smith\nNumber of posts: 3")
  end

  it 'When I click on a user, it should redirect to user/show page' do
    click_on 'John Doe'
    expect(page).to have_content('John Doe')
    expect(current_path).to eq(user_path(@user1))
  end

  it 'should return the correct CSS' do
    expect(page).to have_css("img[src*='https://example.com/john-doe.jpg']")
    expect(page).to have_css("img[src*='https://example.com/jane-smith.jpg']")
  end
end
