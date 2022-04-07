require 'rails_helper'

RSpec.describe 'Creating a post' do
  context 'user is not logged in' do
    scenario 'without login session' do
      visit '/'
      click_link 'New Post'
      expect(page).to have_content('Login')
      expect(page.current_path).to eq new_user_session_path
    end
  end

  context 'user is logged in' do
    before do
      user = create(:user)
      login_as(user, scope: :user)
    end

    context 'with invalid fields' do
      scenario 'shows errors' do  
        visit '/'
        click_link 'New Post'
        fill_in 'Title', with: 'Test blog title'
        click_button 'Post'
        expect(page).to have_content('Body can\'t be blank')
      end
    end    

    context 'with valid fields' do
      scenario 'new post' do  
        visit '/'
        click_link 'New Post'
        fill_in 'Title', with: 'Test blog title'
        fill_in 'Body', with: 'Sample blog test'
        click_button 'Post'
        expect(page).to have_content('Test blog title')
      end
    end

    describe 'show posts' do
      let!(:post) { create :post, title: 'My first blog post' }
  
      scenario 'shows the post' do
        visit root_path
        expect(page).to have_content('My first blog post')
      end
    end    
  end
end
