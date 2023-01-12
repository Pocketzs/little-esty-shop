class ApplicationController < ActionController::Base
  before_action :github 

  def github
    # Usernames and User Commit Totals
    @users = Rails.cache.fetch('users', expires_in: 45.minutes) { GithubFacade.users }
    # Repo Name
    @repo = Rails.cache.fetch('repo', expires_in: 45.minutes) { GithubFacade.repo }
    # Pull Request Count
    @merged_pulls = Rails.cache.fetch('merged_pulls', expires_in: 45.minutes) { GithubFacade.merged_pulls }
  end
end
