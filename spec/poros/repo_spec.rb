require 'rails_helper'

RSpec.describe Repo do
  it 'exists' do
    data = {
      name: 'little-esty-shop'
    }

    repo = Repo.new(data)

    expect(repo).to be_a Repo
    expect(repo.name).to eq 'little-esty-shop'
  end
end