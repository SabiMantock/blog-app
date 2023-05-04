require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
  let!(:user) { User.create(name: 'Salwa', photo: 'photo.jpg', bio: 'Developer', posts_counter: 4) }
  let!(:post) { Post.create(title: 'Post1', text: 'This is my 1st post', user:) }
  let!(:comment) { Comment.create(user:, post:, text: 'First comment') }
  let!(:likes) { Like.create(user:, post:) }

  before do
    visit user_posts_path(user)
  end

  scenario "I can see the post's title" do
    expect(page).to have_content(post.id)
  end

  scenario 'I can see who wrote the post' do
    expect(page).to have_content(user.name)
  end

  scenario 'I can see how many comments it has' do
    expect(page).to have_content("Comments: #{post.comments.count}")
  end

  scenario 'I can see how many likes it has' do
    expect(page).to have_content("Likes: #{post.likes_counter}")
  end

  scenario 'I can see the post body' do
    expect(page).to have_content(post.text)
  end

  scenario 'I can see the username of each commentor' do
    post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  scenario 'I can see the comment each commentor left' do
    post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
