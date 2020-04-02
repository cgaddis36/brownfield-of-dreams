# frozen_string_literal: true

class GithubService
  def repo_creation(user)
    response = get_json('/user/repos', user)
    JSON.parse(response.body, symbolize_names: true)
  end

  def follower_creation(user)
    response = get_json('/user/followers', user)
    JSON.parse(response.body, symbolize_names: true)
  end

  def following_creation(user)
    response = get_json('/user/following', user)
    JSON.parse(response.body, symbolize_names: true)
  end

  def user_profile(github_handle, user)
    response = get_json("/users/#{github_handle}", user)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def get_json(url, user)
    response = conn.get(url, nil, { Authorization: "token #{user.github_token}" })
  end

  def conn
    Faraday.new(url: 'https://api.github.com')
  end
end
