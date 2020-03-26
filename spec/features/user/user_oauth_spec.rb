require 'rails_helper'

RSpec.describe "User dashboard page" do
  vcr_options = {:record => :new_episodes }
  before(:each) do
    OmniAuth.config.mock_auth[:github] = nil
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new( {"provider" => "github",
                                                                  "info" => {"name" => "Harley Dog"},
                                                                  "credentials" =>
                                                                    {"token" => ENV["GITHUB_OAUTH_KEY"],
                                                                    "expires" => false},
                                                                  "extra" =>
                                                                    {"raw_info" =>
                                                                      {"login" => "harleydog",
                                                                       "html_url" => "https://github.com/harleydog",
                                                                       "name" => "Harley Dog",
                                                                       }}})
  end
  it "can connect to Github" do
    user1 = User.create!(email: "user1@gmail.com",
      first_name: "user1",
      last_name: "user1",
      password: "hamburger1",
      role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    user1_repos = 5.times.map { Repo.new(name: "User 1 Repositories", html_url: "www.github.com") }

    allow(user1).to receive(:repos) {user1_repos}
    allow(user1).to receive(:followers) {[]}
    allow(user1).to receive(:following) {[]}

    visit '/dashboard'

    click_on("Connect to Github")

    expect(user1.github_token).to eq(ENV["GITHUB_OAUTH_KEY"])
  end
end
