require 'spec_helper'

describe Implementation do
  fixtures(:users)

  it 'caches score based on the number of votes it has received' do
    dan      = users(:dan)
    function = dan.functions.create!(:name => 'function', :description => 'description')
    impl     = dan.implementations.create!(:function => function, :source => 'foo')

    impl.votes.create(:user => users(:joe))
    impl.reload.score.should == 1
  end
end
