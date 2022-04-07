class CreateComment
  attr_reader :post, :author, :params

  def initialize(post:, author:, params:)
    @post = post
    @author = author
    @params = params
  end

  def call
    validate_post
    validate_author
    validate_not_my_post
    add_comment
  end

  private

  def validate_post
    raise StandardError, 'Post should exist' unless post
  end

  def validate_author
    raise StandardError, 'User must sign in to add a comment' unless author
  end

  def validate_not_my_post
    raise StandardError, 'You can not comment on your own post' if author.id == post.user_id
  end

  def add_comment
    comment = post.comments.create(params)
    comment.user = author
    comment.save!
  end
end
