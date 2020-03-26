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
  
  scenario "can create a new tutorial" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in'tutorial[title]', with: ""
    fill_in'tutorial[description]', with: ""
    fill_in'tutorial[thumbnail]', with: "https://kristennoel.com/wp-content/uploads/2017/08/KN-Jump-thumbnail-FI.jpg"

    click_on("Save")

    expect(current_path).to eq(new_admin_tutorial_path)

    expect(page).to have_content("Title can't be blank and Description can't be blank")
  end
end
