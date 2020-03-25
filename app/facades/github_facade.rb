class GithubFacade
  def repo_creation(user)
    conn = Faraday.new("https://api.github.com")
    respose = conn.get("user/repos", {visibility: 'all'}, {'Accept' => 'application/json', :Authorization => user.github_token})
    parsed = JSON.parse(response.body, symbolize_names: true)
    
  end
end
