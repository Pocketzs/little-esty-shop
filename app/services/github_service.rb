require 'httparty'
require 'json'
require 'pry'

class EndPoints
  def self.repo
    "https://api.github.com/repos/pocketzs/little-esty-shop"
  end

  def self.contributors
    "https://api.github.com/repos/Pocketzs/little-esty-shop/contributors" #{/collaborator}
  end

  def self.collaborators
    "https://api.github.com/repos/Pocketzs/little-esty-shop/collaborators" #{/collaborator}
  end

  def self.commits(person)
    "https://api.github.com/repos/Pocketzs/little-esty-shop/commits?author=#{person}" #{/sha}
  end

  def self.merges
    "https://api.github.com/repos/Pocketzs/little-esty-shop/merges"
  end
end

class GithubService
  attr_reader :data

  def initialize(url)
    @data = get_url(url)
  end
  
  def get_url(url)
    # open unencrypted credentials file and call it github: tolken (secret)
    # to open the credentials file we want to do rails credentials:edit, then add the keys
    # response = HTTParty.get(url, headers: { "User-Agent" => "Pocketzs", "Authorization" => "Token #{Rails.application.credentials.config[:github]}")
    response = HTTParty.get(url)
    parsed_info(response)
  end

  def parsed_info(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

class Contributors
  attr_reader :contributors
  def initialize(data)
    @contributors = []
    data.each do |contributor|
      @contributors << contributor[:login] 
    end
  end
end

class RepositoryName
  attr_reader :name
  def initialize(data)
    @name = data[:name]
  end
end

class RepositoryCommits
  attr_reader :commits
  def initialize(data)
    @commits = data.map do |thing|
      thing = thing[:commit][:message]
    end
  end
end


# Fix this one to be similar to above (map or each)
class RepositoryPullRequests
  attr_reader :pull_requests
  def initialize(data)
    @pull_requests = data[:pull_requests]
  end
end

# Repository Name
# service = GithubService.new(EndPoints.repo)
# repo_info = RepositoryName.new(service.data)

# Contributor Names - Requires Authentication
# service = GithubService.new(EndPoints.contributors)
# info = Contributors.new(service.data)

# Commit Descriptions In An Array For Specific User
# service = GithubService.new(EndPoints.commits("jlweave"))
# info = RepositoryCommits.new(service.data)