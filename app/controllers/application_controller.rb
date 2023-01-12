class ApplicationController < ActionController::Base
  before_action :github 

  def github
    repo = GithubService.new(EndPoints.repo)
    @repo_name = RepositoryName.new(repo.data)

    # Contributor Names
    contributors = GithubService.new(EndPoints.contributors)
    @contributor_names = Contributors.new(contributors.data)

    # Commit Descriptions In An Array For Specific User
    commits = GithubService.new(EndPoints.commits("jlweave"))
    @commits_count = RepositoryCommits.new(commits.data)

    # Pull Request Count
    pulls = GithubService.new(EndPoints.pulls("closed"))
    @pr_count = RepositoryPullRequests.new(pulls.data).count
  end
end
