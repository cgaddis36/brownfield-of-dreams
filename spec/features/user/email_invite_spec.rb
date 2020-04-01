require 'rails_helper'

RSpec.describe 'User Invite', type: :feature do
  before(:each) do
    @user = User.create!(email: 'user1@gmail.com',
                      first_name: 'Meghan',
                      last_name: 'Stovall',
                      password: 'password1',
                      role: 0,
                      github_token: "d3dce97f4fe7d42e913985756a13986d2e3db9e9",
                      url: "https://github.com/meghanstovall",
                      email_confirm: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'can send an invite with a Github handle', :vcr do
    visit "/dashboard"

    click_on 'Send an Invite'
    expect(current_path).to eq('/invite')

    fill_in :github_handle, with: "cgaddis36"

    click_on "Send Invite"
    expect(current_path).to eq("/dashboard")

    expect(page).to have_content("Successfully sent invite!")
  end

  it "can't invite without a github handle", :vcr do
    visit "/dashboard"

    click_on 'Send an Invite'
    expect(current_path).to eq('/invite')

    fill_in :github_handle, with: "holmesm8"

    click_on "Send Invite"
    expect(current_path).to eq("/dashboard")

    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
