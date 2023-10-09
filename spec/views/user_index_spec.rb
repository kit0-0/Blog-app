require 'rails_helper'

RSpec.feature 'User Index', type: :feature do
  scenario 'visiting the user index page' do
    User.create(name: 'John', photo: 'https://example.com/john-photo.png')
    User.create(name: 'Mary', photo: 'https://example.com/mary-photo.png')

    visit users_path

    expect(page).to have_content('John')
    expect(page).to have_content('Mary')
    expect(page).to have_css("img[alt='']", count: User.where(photo: '').count)
end

  scenario 'visiting the user index page, you see the number of posts each user has written..' do
    user1 = User.create(name: 'John')
    User.create(name: 'Mary')
    Post.create(author: user1, title: 'first post')
    Post.create(author: user1, title: 'second post')
    Post.create(author: user1, title: 'third post')

    visit users_path

    expect(page).to have_content('3')
    expect(page).to have_content('0')
  end

  scenario 'clicking on a user redirects to their show page' do
    user = User.create(name: 'Jane')

    visit users_path

    click_link 'Jane'

    expect(page).to have_current_path(user_posts_path(user))
  end
end
