# frozen_string_literal: true

require 'rails_helper'

feature 'An admin visiting the admin dashboard' do
  scenario 'can see all tutorials' do
    admin = create(:admin)
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    expect(page).to have_css(".admin-tutorial-card-#{tutorial1.id}")
    expect(page).to have_css(".admin-tutorial-card-#{tutorial2.id}")
  end
end
