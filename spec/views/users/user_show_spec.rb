require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  let!(:user) { User.create(name: 'Salwa', photo: 'photo.jpg', bio: 'Developer', posts_counter: 3) }
  let!(:post1) { Post.create(title: 'Post1', text: 'This is my 1st post', user:) }
  let!(:post2) { Post.create(title: 'Post2', text: 'This is my 2nd post', user:) }
  let!(:post3) { Post.create(title: 'Post3', text: 'This is my 3rd post', user:) }

  before do
    visit user_path(user)
  end

  scenario "I can see the user's profile picture" do
    expect(page).to have_css("img[src*='/assets/#{user.photo}']")
  end

  scenario "I can see the user's username" do
    expect(page).to have_content(user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  scenario "I can see the user's bio" do
    expect(page).to have_content(user.bio)
  end

  scenario "I can see the user's first 3 posts" do
    user.posts.first(3).each do |post|
      expect(page).to have_content(post.id)
    end
  end

  scenario "I can see a button that lets me view all of a user's posts" do
    expect(page).to have_link('See All Posts', href: "/users/#{user.id}/posts")
  end

  scenario "When I click a user's post, it redirects me to that post's show page" do
    click_link(href: "/users/#{user.id}/posts/#{post1.id}")
    expect(current_path).to eq(user_post_path(user, post1))
  end

  scenario "When I click to see all posts, it redirects me to the user's post's index page" do
    click_link('See All Posts')
    expect(current_path).to eq(user_posts_path(user))
  end
end
