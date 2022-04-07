require 'rails_helper'

RSpec.describe 'Creating a comment' do
  context 'user is not logged in' do
    it 'shows login link' do
      user = create(:user)
      post = create(:post, user: user)

      visit '/'
      click_link post.title
      expect(page).to have_current_path post_path(post), ignore_query: true

      expect(page).to have_content('Please sign in to add a comment')
    end
  end

  context 'when commenting on his own post' do
    it 'can not creates a comment for own post' do
      post_title = 'Sample Post'
      post = create(:post, title: post_title)
      user = post.user
      login_as(user, scope: :user)

      visit '/'
      click_link post_title

      fill_in 'comment_body', with: 'Sample comment'
      click_button 'Create Comment'

      expect(page).to have_content('You can not comment on your own post')
    end
  end

  context "when commenting on somebody else's post" do
    before do
      prepare_page
    end

    it 'creates a comment' do
      visit '/'

      click_link 'Sample Post'

      fill_in 'comment_body', with: 'Sample comment'
      click_button 'Create Comment'

      expect(page).to have_content('Sample comment')
    end

    it 'shows errors' do
      visit '/'

      click_link 'Sample Post'

      fill_in 'comment_body', with: ''
      click_button 'Create Comment'

      expect(page).to have_content("Validation failed: Body can't be blank")
    end
  end

  private

  def prepare_page
    post = create(:post, title: 'Sample Post')

    user = create(:user)
    login_as(user, scope: :user)
  end
end
