require 'rails_helper'

feature "An admin" do
  vcr_options = {:record => :new_episodes }
  scenario "can create a new tutorial" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in'tutorial[title]', with: "Man jumps 250 foot cliff"
    fill_in'tutorial[description]', with: "Killer GoPro video"
    fill_in'tutorial[thumbnail]', with: "https://kristennoel.com/wp-content/uploads/2017/08/KN-Jump-thumbnail-FI.jpg"


    click_on("Save")

    tutorial = Tutorial.last

    expect(current_path).to eq("/tutorials/#{tutorial.id}")

    expect(page).to have_content("Successfully created tutorial.")
  end
end

# When I visit '/admin/tutorials/new'
# And I fill in 'title' with a meaningful name
# And I fill in 'description' with a some content
# And I fill in 'thumbnail' with a valid YouTube thumbnail
# And I click on 'Save'
# Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
# And I should see a flash message that says "Successfully created tutorial."
#
#  Sad path accounted for
