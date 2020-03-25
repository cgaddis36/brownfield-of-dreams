class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def repos
    if github_token.blank?
      return nil
    else
      github_api = GithubFacade.new
      require "pry"; binding.pry
      github_api.repo_creation(self).map {|repo| Repo.new(repo)}
    end 
  end
end
