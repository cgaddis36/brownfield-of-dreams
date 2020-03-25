class GithubService

  def repos(user)
    get_json("/user/repos")
  end

  def followers(user)
    get_json("/user/followers")
  end

  private
    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)[:results]
    end

    def conn
      Faraday.new(url: "https://api.github.org") do |faraday|
        faraday.headers["X-API-KEY"] = ENV['GITHUB_API_KEY']
      end
    end
end
