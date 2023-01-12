class GithubFacade
  def self.users
    json = GithubService.users
    json.map do |data|
      User.new(data) unless ["BrianZanti","timomitchel","scottalexandra","cjsim89","jamisonordway", "mikedao"].include?(data[:author][:login])
    end.compact
  end

  def self.repo
    json = GithubService.repo
    Repo.new(json)
  end

  def self.merged_pulls
    json = GithubService.merged_pulls
    PullRequests.new(json)
  end
end
