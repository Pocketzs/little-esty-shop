class GithubService
  def self.repo
    get_url
  end

  def self.users
    get_url("/stats/contributors")
  end
  
  def self.merged_pulls
    get_url("/pulls?state=closed&per_page=100")
  end

  def self.get_url(path = nil)
    response = HTTParty.get("https://api.github.com/repos/pocketzs/little-esty-shop#{path}")
    JSON.parse(response.body, symbolize_names: true)
  end
end