# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Friendships' do
  before(:each) do
    @user1 = User.create!(email: 'user1@gmail.com',
                      first_name: 'Meghan',
                      last_name: 'Stovall',
                      password: 'password1',
                      role: 0,
                      github_token: ENV['token'],
                      url: "https://github.com/meghanstovall",
                      email_confirm: true)

    @user2 = User.create!(email: 'user2@gmail.com',
                      first_name: 'Chase',
                      last_name: 'Gaddis',
                      password: 'password2',
                      role: 0,
                      github_token: ENV['c_token'],
                      url: "https://github.com/cgaddis36",
                      email_confirm: true)

    @user3 = User.create!(email: 'user3@gmail.com',
                          first_name: 'User',
                          last_name: 'Three',
                          password: 'password3',
                          role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  it 'can see an Add Friend button in the github dashboard', :vcr do
    visit '/dashboard'

    within '#following' do
      expect(page).to_not have_link('Add Friend')
    end

    within '#followers' do
      expect(page).to have_link('Add Friend')
    end

    within '#followers' do
      click_on 'Add Friend'
    end

    expect(current_path).to eq(dashboard_path)
    expect(@user1.friendships.count).to eq(1)

    within '#friends' do
      expect(page).to have_link(@user2.first_name)
    end
  end
end
