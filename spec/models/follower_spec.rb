require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_presence_of :thumbnail}
  end


  describe "relationships" do
    it { should have_many :videos }
  end

  describe "methods" do
    it "#find_friend" do
      user1 = User.create(email: 'user1@email.com', password: 'password1', first_name:'Jim', role: 0, email_confirm: true)
      user2 = User.create(email: 'user2@email.com', password: 'password1', first_name:'Jim', role: 0, email_confirm: true)
      friendship = Friendship.create!(user_id: user1.id, friend_id: user2.id)
      expect(friendship.find_friend).to eq(user2)
    end
  end
end
