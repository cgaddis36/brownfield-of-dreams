class GithubFacade
  def repo_creation(user)
    conn = Faraday.new("https://api.github.com")
    response = conn.get("user/repos", {visibility: 'all'}, {'Accept' => 'application/json', :Authorization => user.github_token})
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def followers(user)
    conn = Faraday.new("https://api.github.com")
    response = conn.get("user/followers", {visibility: 'all'}, {'Accept' => 'application/json', :Authorization => user.github_token})
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
