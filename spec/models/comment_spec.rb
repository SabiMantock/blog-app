require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Jane Doe', photo: 'photo url', bio: 'A developer from Ghana', posts_counter: 0) }
  let(:post) do
    Post.create(author: user, title: 'From zero to hero', text: 'Journey from no stack to full-stack',
                comments_counter: 0, likes_counter: 2)
  end

  subject do
    Comment.create(post:, author_id: user, text: 'This is a comment')
  end
end
