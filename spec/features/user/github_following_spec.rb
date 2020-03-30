require "rails_helper"
describe "User Dashboard: Github Following" do
  it "users can see all users they are following and links to their page", :vcr do
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
    expect(page).to have_content("Following")

    within "#following" do
      expect(page).to have_link("holmesm8")
      expect(page).to have_link("Yetidancer")
      expect(page).to have_link("kathleen-carroll")
      expect(page).to_not have_link("cgaddis36")
    end
  end
end
