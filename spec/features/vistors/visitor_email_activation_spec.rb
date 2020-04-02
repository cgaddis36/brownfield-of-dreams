# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Email Activation' do
  it 'will get email after registering as a new user', :vcr do
    visit '/'

    click_on 'Register'
    expect(current_path).to eq('/register')

    fill_in 'user[email]', with: 'meghan.stovall@gmail.com'
    fill_in 'user[first_name]', with: 'Meghan'
    fill_in 'user[last_name]', with: 'Stovall'
    fill_in 'user[password]', with: 'password1'
    fill_in 'user[password_confirmation]', with: 'password1'

    click_on 'Create Account'
    expect(current_path).to eq('/dashboard')

    expect(page).to have_content('Logged in as Meghan Stovall')
    expect(page).to have_content('This account has not yet been activated. Please check your email.')
    expect(page).to have_content('Status: Inactive')
  end

  it 'user status changes after email has been sent and confirmed' do
    visit '/'

    click_on 'Register'
    expect(current_path).to eq('/register')

    fill_in 'user[email]', with: 'meghan.stovall@gmail.com'
    fill_in 'user[first_name]', with: 'Meghan'
    fill_in 'user[last_name]', with: 'Stovall'
    fill_in 'user[password]', with: 'password1'
    fill_in 'user[password_confirmation]', with: 'password1'

    click_on 'Create Account'
    expect(current_path).to eq('/dashboard')

    User.last.update_column(:email_confirm, true)

    page.refresh

    expect(page).to have_content('Status: Active')
  end
end
