require 'rails_helper'

RSpec.describe 'Users Signup' do
  it 'with valid credentials' do
    visit '/'
    click_link 'Create An Account'
    fill_in 'Username', with: 'test-user'
    fill_in 'Email', with: 'test-user@example.com'
    fill_in 'Password', with: 'password', match: :prefer_exact
    fill_in 'Password confirmation', with: 'password', match: :prefer_exact
    click_button 'Sign up'

    expect(page).to have_content('You have signed up successfully.')
  end

  it 'with invalid credentials' do
    visit '/'
    click_link 'Create An Account'
    fill_in 'Username', with: 'test-user'
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'password', match: :prefer_exact
    click_button 'Sign up'
    expect(page).to have_content('Please review the problems below:')
  end
end
