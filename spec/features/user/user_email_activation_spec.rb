require 'rails_helper'

RSpec.describe "User Email Activation" do
  it "will get email after registering as a new user", :vcr do
    visit "/"
    click_on "Register"
    

  end
end
# Then I should be on "/register"
# And when I fill in an email address (required)
# And I fill in first name (required)
# And I fill in last name (required)
# And I fill in password and password confirmation (required)
# And I click submit
# Then I should be redirected to "/dashboard"
# And I should see a message that says "Logged in as <SOME_NAME>"
# And I should see a message that says "This account has not yet been activated. Please check your email."
