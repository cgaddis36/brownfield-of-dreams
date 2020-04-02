require 'rails_helper'

RSpec.describe Follower, type: :model do
  describe "methods" do
    it "#database?" do
      user = User.create!(email: 'meghanstovall@gmail.com',
                  first_name: 'Meghan',
                  last_name: 'Stovall',
                  password: 'Turing',
                  role: 1,
                  github_token: ENV['token'],
                  url: 'https://github.com/meghanstovall',
                  email_confirm: true)

      follower1 = Follower.new({name: "Meghan", html_url: 'https://github.com/meghanstovall'})
      expect(follower1.database?).to eq(true)

      follower2 = Follower.new({name: "Chase", html_url: 'https://github.com/cgaddis36'})
      expect(follower2.database?).to eq(false)
    end
  end
end
