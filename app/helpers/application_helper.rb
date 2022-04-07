module ApplicationHelper
  def my_article?(post_or_comment)
    post_or_comment.user_id == current_user&.id
  end

  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-danger'
    when 'alert' then 'alert alert-error'
    end
  end

  def display_date_time(dt)
    dt&.strftime("%A, %b #{dt.day.ordinalize}, %Y at %I:%M %p")
  end

  def post_preview(post)
    post.html_safe.truncate_words(100)
  end
end
