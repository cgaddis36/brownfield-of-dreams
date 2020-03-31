require 'rails_helper'

RSpec.describe 'User Friendships' do
  before(:each) do
    @user1 = User.create!(email: 'user1@gmail.com',
                      first_name: 'Meghan',
                      last_name: 'Stovall',
                      password: 'password1',
                      role: 0,
                      github_token: "d3dce97f4fe7d42e913985756a13986d2e3db9e9",
                      url: "https://github.com/meghanstovall")

    @tutorial = create(:tutorial)
    @tutorial1 = create(:tutorial)

    @video1 = create(:video, tutorial_id: @tutorial.id)
    @video2 = create(:video, tutorial_id: @tutorial.id)
    @video3 = create(:video, tutorial_id: @tutorial.id)

    @video4 = create(:video, tutorial_id: @tutorial1.id)
    @video5 = create(:video, tutorial_id: @tutorial1.id)
    @video6 = create(:video, tutorial_id: @tutorial1.id)
    @video7 = create(:video, tutorial_id: @tutorial1.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  it 'can see an Add Friend button in the github dashboard', :vcr do
    visit tutorial_video_path(@tutorial, @video1)

    click_on 'Bookmark'

    visit tutorial_video_path(@tutorial, @video2)
    click_on 'Bookmark'

    visit tutorial_video_path(@tutorial1, @video4)
    click_on 'Bookmark'

    visit tutorial_video_path(@tutorial1, @video5)
    click_on 'Bookmark'

    visit tutorial_video_path(@tutorial1, @video7)
    click_on 'Bookmark'

    visit '/dashboard'

    within '#bookmarks' do
      expect(page).to have_content(@video1.title)
      expect(page).to have_content(@video2.title)
      expect(page).to have_content(@video4.title)
      expect(page).to have_content(@video5.title)
      expect(page).to have_content(@video7.title)
      expect(page).to_not have_content(@video3.title)
      expect(page).to_not have_content(@video6.title)
    end 
  end
end

# As a logged in user
# When I visit '/dashboard'
# Then I should see a list of all bookmarked segments under the Bookmarked Segments section
# And they should be organized by which tutorial they are a part of
# And the videos should be ordered by their position
