require 'rails_helper'

RSpec.describe PullRequests do
  it 'exists' do
    data = [{state:'closed'}, {state:'closed'}, {state:'closed'}, {state:'closed'}, {state:'closed'}]

    pr = PullRequests.new(data)

    expect(pr).to be_a PullRequests
    expect(pr.count).to eq 5
  end
end