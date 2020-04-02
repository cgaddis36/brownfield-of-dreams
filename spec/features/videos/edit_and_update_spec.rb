require 'rails_helper'

RSpec.describe "Video Controller" do
  before(:each) do
    @user = User.create!(email: 'meghanstovall@gmail.com',
                          first_name: 'Meghan',
                          last_name: 'Stovall',
                          password: 'Turing',
                          role: 1,
                          github_token: ENV['token'],
                          url: 'https://github.com/meghanstovall',
                          email_confirm: true)

    @tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    @video1 = create(:video, title: 'The Bunny Ears Technique', tutorial: @tutorial)
    @video2 = create(:video, title: 'The Owl Ears Technique', tutorial: @tutorial)
    @video3 = create(:video, title: 'The Dog Ears Technique', tutorial: @tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "as an admin, I can edit a video", :vcr do
    visit "/tutorials/#{@tutorial.id}?video_id=#{@video1.id}"

    within "#video-#{@video1.id}" do
      click_on "Edit"
    end
    expect(current_path).to eq(admin_video_path(@video1.id))
  end
end
