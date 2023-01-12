class PullRequests
  attr_reader :count
  def initialize(data)
    @count = data.count
  end
end