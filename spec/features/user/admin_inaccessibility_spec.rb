require 'rails_helper'

RSpec.describe "user accessing admin pages" do
  it "is not accessible" do
    user1 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    expect { raise visit admin_dashboard_path }.to raise_error(ActionController::RoutingError)
  end
end
