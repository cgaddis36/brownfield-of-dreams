# frozen_string_literal: true

require 'rails_helper'
describe 'User Dashboard: Github Repositories' do
  vcr_options = { record: :new_episodes }
  it 'as a user i should see my github repo section' do
    user1 = User.create!(email: 'user1@gmail.com',
                         first_name: 'user1',
                         last_name: 'user1',
                         password: 'hamburger1',
                         role: 0,
                         github_token: ENV['GITHUB_API_KEY'])

    user2 = User.create!(email: 'user2@gmail.com',
                         first_name: 'user2',
                         last_name: 'user2',
                         password: 'hamburger2',
                         role: 0,
                         github_token: '5e6e5546ee4fdd541c2aa701699478dedfbd7cd1')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    user1_repos = 5.times.map { Repo.new(name: 'User 1 Repositories', html_url: 'www.github.com') }
    user2_repos = 5.times.map { Repo.new(name: 'User 2 Repositories', html_url: 'www.github.com') }

    allow(user1).to receive(:repos) { user1_repos }
    allow(user2).to receive(:repos) { user2_repos }

    allow(user1).to receive(:followers) { [] }
    allow(user1).to receive(:following) { [] }

    visit '/dashboard'
    expect(page).to have_content('GitHub Repositories')
    within '#repos' do
      expect(page).to have_link('User 1 Repositories', count: 5)
      expect(page).to_not have_link('User 2 Repositories')
    end
  end

  it "doesn't display github section when a user does not have a token" do
    user1 = User.create!(email: 'user1.gmail.com',
                         first_name: 'user1',
                         last_name: 'user1',
                         password: 'hamburger1',
                         role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit '/dashboard'
    expect(page).to_not have_content('Github Repositories')
  end
end
