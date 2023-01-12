require "rails_helper"

RSpec.describe User do
  it "exists" do
    data = {
      author: { login: "Leslie Knope" },
      total: "1"
    }

    user = User.new(data)

    expect(user).to be_a User
    expect(user.username).to eq("Leslie Knope")
    expect(user.commit_total).to eq("1")
  end
end