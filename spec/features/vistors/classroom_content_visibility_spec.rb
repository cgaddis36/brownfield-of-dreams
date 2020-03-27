require 'rails_helper'
 RSpec.describe "As a Visitor" do
   it "I should only see tutorials with classroom content if I am logged in." do
     tutorial1 = create(:tutorial)
     tutorial2 = create(:tutorial, classroom: true)

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
 end
