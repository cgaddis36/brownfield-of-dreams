# frozen_string_literal: true

require 'rails_helper'

feature 'An admin can delete a tutorial' do
  scenario 'and it should no longer exist' do
    admin = create(:admin)
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    expect(page).to have_css(".admin-tutorial-card-#{tutorial1.id}")
    expect(page).to have_css(".admin-tutorial-card-#{tutorial2.id}")

    within(".admin-tutorial-card-#{tutorial1.id}") do
      click_link 'Delete'
    end

    expect(page).to have_css(".admin-tutorial-card-#{tutorial2.id}")
  end

  it 'deleting a tutorial will also delete videos in that tutoria' do
    admin = create(:admin)
    tutorial = Tutorial.create!(title: 'Galvanize', description: "Consuming API's",
                                thumbnail: 'http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg',
                                playlist_id: '5', classroom: false)
    video1 = create(:video)
    video2 = create(:video)
    tutorial.videos << video1
    tutorial.videos << video2

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    within(".admin-tutorial-card-#{tutorial.id}") do
      click_link 'Delete'
    end

    tutorials = Tutorial.all
    expect(Tutorial.all.count).to eq(2)

    within(".admin-tutorial-card-#{tutorials.first.id}") do
      expect(page).to_not have_content('Galvanize')
    end

    within(".admin-tutorial-card-#{tutorials.last.id}") do
      expect(page).to_not have_content('Galvanize')
    end

    expect(Video.all.count).to eq(0)
  end
end
