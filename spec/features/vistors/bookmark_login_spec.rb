# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor' do
  it 'Has a flash message to login/register when you try to bookmark a video' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to_not have_button('Bookmark')

    expect(page).to have_content('User must login to bookmark videos.')

    expect(current_path).to eq(tutorial_path(tutorial))
  end
end
