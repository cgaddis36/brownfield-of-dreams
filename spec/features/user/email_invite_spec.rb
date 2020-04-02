require 'rails_helper'

RSpec.describe "User Email Invite" do
  before(:each) do
    @user1 = User.create!(email: 'user1@gmail.com',
                        first_name: 'Meghan',
                        last_name: 'Stovall',
                        password: 'password1',
                        role: 0,
                        github_token: ENV['token'],
                        url: "https://github.com/meghanstovall",
                        email_confirm: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  it "can send email with valid github handle", :vcr do
    visit '/dashboard'

    click_on 'Send an Invite'
    expect(current_path).to eq('/invite')

    fill_in :invite_github_handle, with: "BrianZanti"

    click_on "Send Invite"
    expect(current_path).to eq("/dashboard")

    expect(page).to have_content("Successfully sent invite!")
  end

  it "can't send email with out a valid github email", :vcr do
    visit "/dashboard"

    click_on 'Send an Invite'
    expect(current_path).to eq('/invite')

    fill_in :invite_github_handle, with: "cgaddis36"

    click_on "Send Invite"
    expect(current_path).to eq("/dashboard")

    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
