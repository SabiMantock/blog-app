require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  let!(:user1) { User.create(name: 'Salwa', photo: 'photo.jpg', bio: 'Developer', posts_counter: 4) }
  let!(:user2) { User.create(name: 'Anas', photo: 'photo.jpg', bio: 'Pentester', posts_counter: 10) }
  let!(:post1) { Post.create(user: user1) }
  let!(:post2) { Post.create(user: user1) }
  let!(:post3) { Post.create(user: user2) }

  before do
    visit users_path
  end

  scenario 'I can see the username of all other users' do
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)
  end

  scenario 'I can see the profile picture for each user' do
    expect(page).to have_css("img[src*='/assets/#{user1.photo}']")
    expect(page).to have_css("img[src*='/assets/#{user2.photo}']")
  end

  scenario 'I can see the number of posts each user has written' do
    expect(page).to have_content("Number of post: #{user1.posts.count}")
    expect(page).to have_content("Number of post: #{user2.posts.count}")
  end

  scenario "When I click on a user, I am redirected to that user's show page" do
    find("a[href='/users/#{user1.id}']").click
    expect(current_path).to eq(user_path(user1))
    expect(page).to have_content(user1.name)

    visit users_path
    find("a[href='/users/#{user2.id}']").click
    expect(current_path).to eq(user_path(user2))
    expect(page).to have_content(user2.name)
  end
end
