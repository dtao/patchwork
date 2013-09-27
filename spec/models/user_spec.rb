require 'spec_helper'

describe User do
  fixtures(:users, :functions)

  it "caches score based on the number of votes a user's implementations have received" do
    dan   = users(:dan)
    func  = functions(:dummy)
    impl1 = dan.implementations.create(:function => func, :source => 'foo')
    impl2 = dan.implementations.create(:function => func, :source => 'bar')

    impl1.votes.create(:user => users(:joe))
    impl2.votes.create(:user => users(:johnny))

    dan.reload.score.should == 2
  end
end
