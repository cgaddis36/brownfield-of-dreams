class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def bookmark_finder
    self.videos.joins(:tutorial)    
  end

  def repos
    if github_token.blank?
      return nil
    else
      github_api = GithubService.new
      github_api.repo_creation(self).map {|repo| Repo.new(repo)}
    end
  end

  def followers
    if github_token.blank?
      return nil
    else
      github_api = GithubService.new
      github_api.follower_creation(self).map {|repo| Follower.new(repo)}
    end
  end

  def following
    if github_token.blank?
      return nil
    else
      github_api = GithubService.new
      github_api.following_creation(self).map {|repo| Following.new(repo)}
    end
  end
end
