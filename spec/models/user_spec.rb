# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
    it {should validate_uniqueness_of(:email)}
  end

  describe "relationships" do
    it { should have_many :friendships }
    it { should have_many :user_videos }
    it { should have_many(:videos).through(:user_videos)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'methods' do
    it '#repos' do
      user1 = User.create(email: 'user1@email.com', password: 'password1', first_name: 'Jim', role: 0)

      expect(user1.repos).to eq(nil)

      user2 = User.create(email: 'user2@email.com', password: 'password2', first_name: 'Joe', role: 0, github_token: (ENV['GITHUB_API_KEY']).to_s)
      user2_repos = 5.times.map { Repo.new(name: 'Repositories', html_url: 'www.github.com') }

      allow(user2).to receive(:repos) { user2_repos }

      expect(user2.repos).to eq(user2_repos)
    end

    it '#followers' do
      user1 = User.create(email: 'user1@email.com', password: 'password1', first_name: 'Jim', role: 0)

      expect(user1.followers).to eq(nil)

      user2 = User.create(email: 'user2@email.com', password: 'password2', first_name: 'Joe', role: 0, github_token: (ENV['GITHUB_API_KEY']).to_s)
      user2_followers = 5.times.map { Follower.new(name: 'Followers', html_url: 'www.github.com') }

      allow(user2).to receive(:followers) { user2_followers }

      expect(user2.followers).to eq(user2_followers)
    end

    it '#following' do
      user1 = User.create(email: 'user1@email.com', password: 'password1', first_name: 'Jim', role: 0)

      expect(user1.following).to eq(nil)

      user2 = User.create(email: 'user2@email.com', password: 'password2', first_name: 'Joe', role: 0, github_token: (ENV['GITHUB_API_KEY']).to_s)
      user2_following = 5.times.map { Following.new(name: 'Following', html_url: 'www.github.com') }

      allow(user2).to receive(:following) { user2_following }

      expect(user2.following).to eq(user2_following)
    end

    it "#bookmark_finder" do
      user1 = User.create(email: 'user1@email.com', password: 'password1', first_name:'Jim', role: 0)
      tutorial = create(:tutorial)
      video = create(:video, tutorial_id: tutorial.id)
      user_video = UserVideo.create(video_id: video.id, user_id: user1.id)

      expect(user1.bookmark_finder[0]).to eq(video)
    end

    it "#status" do
      user1 = User.create(email: 'user1@email.com', password: 'password1', first_name:'Jim', role: 0, email_confirm: true)
      expect(user1.status).to eq("Active")

      user2 = User.create(email: 'user1@email.com', password: 'password1', first_name:'Jim', role: 0, email_confirm: false)
      expect(user2.status).to eq("Inactive")
    end
  end
end
