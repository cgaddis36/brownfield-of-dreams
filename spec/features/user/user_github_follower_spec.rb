require "rails_helper"
describe "User Dashboard: Github Followers" do
  vcr_options = {:record => :new_episodes }
  it "users can see all followers and links to their page" do
    user1 = User.create!(email: "user1@gmail.com",
                      first_name: "user1",
                      last_name: "user1",
                      password: "hamburger1",
                      role: 0,
                      github_token: ENV["GITHUB_API_KEY"])
    user2 = User.create!(email: "user2@gmail.com",
                      first_name: "user2",
                      last_name: "user2",
                      password: "hamburger2",
                      role: 0,
                      github_token: "5e6e5546ee4fdd541c2aa701699478dedfbd7cd1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    user1_repos = 5.times.map { Repo.new(name: "User 1 Repositories", html_url: "www.github.com") }
    followers1 = 5.times.map { Follower.new(name: "Follower1", html_url: "www.github.com") }
    followers2 = 5.times.map { Follower.new(name: "Follower2", html_url: "www.github.com") }

    allow(user1).to receive(:repos) {user1_repos}
    allow(user1).to receive(:followers) {followers1}
    allow(user2).to receive(:followers) {followers2}

    visit '/dashboard'
    expect(page).to have_content("Followers")
    within "#followers" do
      expect(page).to have_link("Follower1", count: 5)
      expect(page).to_not have_link("Follower2")
    end
  end
end
