require 'rails_helper'

RSpec.describe GithubFacade do
  describe 'class methods' do
    describe '.users' do
      it 'returns an array of User objects' do
        expect(GithubFacade.users).to all be_a User
      end
    end

    describe '.repo' do
      it 'returns a Repo object with a name' do
        expect(GithubFacade.repo).to be_a Repo
        expect(GithubFacade.repo.name).to be_a String
      end
    end

    describe '.merged_pulls' do
      it 'returns a PullRequests object with a an integer count of closed prs' do
        expect(GithubFacade.merged_pulls).to be_a PullRequests
        expect(GithubFacade.merged_pulls.count).to be_an Integer
      end
    end
  end
end