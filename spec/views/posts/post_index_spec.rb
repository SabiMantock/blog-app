require 'rails_helper'

RSpec.feature 'Post Index Page', type: :feature do
  let!(:user) { User.create(name: 'Salwa', photo: 'photo.jpg', bio: 'Developer', posts_counter: 4) }
  let!(:post1) { Post.create(title: 'Post1', text: 'First Post', user:) }
  let!(:post2) { Post.create(title: 'Post2', text: 'Second Post', user:) }
  let!(:post3) { Post.create(title: 'Post3', text: 'Third Post', user:) }
  let!(:comment1) { Comment.create(user:, post: post1, text: 'Comment 1') }
  let!(:comment2) { Comment.create(user:, post: post1, text: 'Comment 2') }
  let!(:comment3) { Comment.create(user:, post: post1, text: 'Comment 3') }

  before do
    visit user_posts_path(user)
  end

  scenario "I can see the user's profile picture" do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  scenario "I can see the user's username" do
    expect(page).to have_content(user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  scenario "I can see a post's title" do
    user.posts.each do |post|
      expect(page).to have_content(post.id)
    end
  end

  scenario "I can see some of the post's body" do
    user.posts.each do |post|
      expect(page).to have_content(post.text.truncate(100))
    end
  end

  scenario 'I can see the first comments on a post' do
    # Assuming you have a method to get the first N comments on a post
    user.posts.each do |post|
      post.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end

  scenario 'I can see how many comments a post has' do
    user.posts.each do |post|
      expect(page).to have_content("Comments: #{post.comments_counter}")
    end
  end

  scenario 'I can see how many likes a post has' do
    user.posts.each do |post|
      expect(page).to have_content("Likes: #{post.likes_counter}")
    end
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_button('Pagination')
  end

  scenario "When I click on a post, it redirects me to that post's show page" do
    post = user.posts.first
    find("a[href='#{user_post_path(user, post)}']").click
    expect(current_path).to eq(user_post_path(user, post))
  end
end
