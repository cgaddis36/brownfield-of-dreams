# require 'rails_helper'
#
# RSpec.describe 'User invites' do
#   vcr_options = {:record => :new_episodes }
#   before(:each) do
#     @user1 = User.create!(email: 'user1@gmail.com',
#                       first_name: 'Meghan',
#                       last_name: 'Stovall',
#                       password: 'password1',
#                       role: 0,
#                       github_token: "49217ac146e7db9618653e116848727e9780dacd",
#                       url: "https://github.com/meghanstovall")
#
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
#   end
#
#   it 'can invite a friend by github handle', :vcr do
#
#     visit '/dashboard'
#
#
#   end
# end
