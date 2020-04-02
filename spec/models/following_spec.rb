require 'rails_helper'

RSpec.describe Following, type: :model do
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

      following1 = Following.new({name: "Meghan", html_url: 'https://github.com/meghanstovall'})
      expect(following1.database?).to eq(true)

      following2 = Following.new({name: "Chase", html_url: 'https://github.com/cgaddis36'})
      expect(following2.database?).to eq(false)
    end
  end
end
