class User
  attr_reader :username, :commit_total

  def initialize(data)
    @username = data[:author][:login]
    @commit_total = data[:total]
  end
end