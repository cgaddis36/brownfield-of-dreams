# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'As a Visitor' do
  it 'On tutorials show page, I should only see tutorials with classroom content if I am logged in.' do
    tutorial1 = Tutorial.create!(title: 'Building blocks ABC', description: 'This is easy!', thumbnail: 'https://media.nbcnewyork.com/2019/09/abcblocks.gif?resize=850%2C478', classroom: false)
    tutorial2 = Tutorial.create!(title: 'Coding for dummies', description: 'Really short video', thumbnail: 'https://cdn.shopify.com/s/files/1/0922/7486/products/Letters-Hape.jpg?v=1544761721', classroom: true)

    visit tutorials_path

    expect(page).to have_content(tutorial1.title)
    expect(page).to have_content(tutorial1.description)

    expect(page).to_not have_content(tutorial2.title)
    expect(page).to_not have_content(tutorial2.description)

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorials_path

    expect(page).to have_content(tutorial1.title)
    expect(page).to have_content(tutorial1.description)

    expect(page).to have_content(tutorial2.title)
    expect(page).to have_content(tutorial2.description)
  end
  it 'On the Welcome page, I should only see tutorials with classroom content if I am logged in.' do
    tutorial1 = Tutorial.create!(title: 'Building blocks ABC', description: 'This is easy!', thumbnail: 'https://media.nbcnewyork.com/2019/09/abcblocks.gif?resize=850%2C478', classroom: false)
    tutorial2 = Tutorial.create!(title: 'Coding for dummies', description: 'Really short video', thumbnail: 'https://cdn.shopify.com/s/files/1/0922/7486/products/Letters-Hape.jpg?v=1544761721', classroom: true)

    visit root_path

    expect(page).to have_content(tutorial1.title)
    expect(page).to have_content(tutorial1.description)

    expect(page).to_not have_content(tutorial2.title)
    expect(page).to_not have_content(tutorial2.description)

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorials_path

    expect(page).to have_content(tutorial1.title)
    expect(page).to have_content(tutorial1.description)

    expect(page).to have_content(tutorial2.title)
    expect(page).to have_content(tutorial2.description)
  end
end
