require 'rails_helper'

RSpec.describe GithubService do
  describe 'class methods' do
    describe '.users' do
      it 'returns repo stats contributors data with username and commit totals' do
        search = GithubService.users
        expect(search).to be_an Array
        user_stats = search.first
        expect(user_stats[:total]).to be_an Integer
        expect(user_stats[:author][:login]).to be_a String
      end
    end

    describe '.repo' do
      it 'returns the repo data including repo name' do
        search = GithubService.repo
        expect(search).to be_a Hash
        expect(search[:name]).to be_a String
      end
    end

    describe '.merged_pulls' do
      it 'it returns data for closed pull requests' do
        search = GithubService.merged_pulls
        expect(search).to be_an Array
        expect(search).to all include(state: 'closed')
      end
    end
  end
end