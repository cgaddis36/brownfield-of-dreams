require "rails_helper"
describe "User Dashboard: Github Repositories" do
  it "as a user I should see my github repo section", :vcr do
    user1 = User.create!(email: 'user1@gmail.com',
                      first_name: 'Meghan',
                      last_name: 'Stovall',
                      password: 'password1',
                      role: 0,
                      github_token: "d3dce97f4fe7d42e913985756a13986d2e3db9e9",
                      url: "https://github.com/meghanstovall")

    user2 = User.create!(email: 'user2@gmail.com',
                      first_name: 'Chase',
                      last_name: 'Gaddis',
                      password: 'password2',
                      role: 0,
                      github_token: "49217ac146e7db9618653e116848727e9780dacd",
                      url: "https://github.com/cgaddis36")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit '/dashboard'
    expect(page).to have_content("GitHub Repositories")
    within "#repos" do
      expect(page).to have_link('ClassSharedRepo')
      expect(page).to have_link('ConflictTestJ')
      expect(page).to have_link('JaegerRepo')
      expect(page).to have_link('lab4-meghanstovall')
      expect(page).to have_link('LabUnitTestingRefactoring')
    end
  end

  it "doesn't display github section when a user does not have a token" do
    user1 = User.create!(email: "user1.gmail.com",
                      first_name: "user1",
                      last_name: "user1",
                      password: "hamburger1",
                      role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit '/dashboard'
    expect(page).to_not have_content("Github Repositories")
  end
end
