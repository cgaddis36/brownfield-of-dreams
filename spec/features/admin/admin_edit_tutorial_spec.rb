require 'rails_helper'

feature "An admin can edit a tutorial" do
  scenario "and it should update the attributes" do
    admin = create(:admin)
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    video = create(:video, tutorial_id: tutorial1.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css(".admin-tutorial-card-#{tutorial1.id}")
    expect(page).to have_css(".admin-tutorial-card-#{tutorial2.id}")
    within(".admin-tutorial-card-#{tutorial1.id}") do
      click_link 'Edit'
    end

    within ".tag-field" do
      fill_in "tutorial_tag_list", with: "Awesome"
      click_on("Update Tags")
    end
    expect(tutorial1.tags).to_not be_empty
  end
end
