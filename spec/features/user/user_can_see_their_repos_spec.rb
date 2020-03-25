require "rails_helper"
describe "User Dashboard: Github Repositories" do
  vcr_options = {:record => :new_episodes }
  it "as a user i should see my github repo section" do

    user1 = User.create!(email: "user1.gmail.com",
                      first_name: "user1",
                      last_name: "user1",
                      password: "hamburger1",
                      role: 0,
                      github_token: ENV["GITHUB_API_KEY"])


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
    github_repos = 5.times.map { Repo.new(name: "User Repositories", html_url: "www.github.com") }
    allow(user1).to receive(:repos) {github_repos}
    visit '/dashboard'
    expect(page).to have_link('User Repositories', href: 'www.github.com', count: 5)
  end
end
