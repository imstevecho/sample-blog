require 'rails_helper'

describe CreateComment do
  let(:post) { create(:post) }

  context 'when invalid input parameters are passed' do
    it 'returns error when user did not signed in' do
      comment_params = { body: 'awesome article' }
      author = nil

      expect do
        CreateComment.new(post: post, author: author, params: comment_params).call
      end.to raise_error(StandardError, 'User must sign in to add a comment')
    end

    it 'returns error when there is no comment body' do
      comment_params = { body: nil }
      author = create(:user)

      expect do
        CreateComment.new(post: post, author: author, params: comment_params).call
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'returns error when the same user comments on their own post' do
      comment_params = { body: 'commenting on my post' }
      author = post.user

      expect do
        CreateComment.new(post: post, author: author, params: comment_params).call
      end.to raise_error(StandardError, 'You can not comment on your own post')
    end
  end

  context 'when valid input parameters are provided' do
    it 'successfully creates a comment' do
      comment_params = { body: 'my awesome article' }
      author = create(:user)

      expect do
        CreateComment.new(post: post, author: author, params: comment_params).call
      end.to change(Comment, :count).by(1)
    end
  end
end
