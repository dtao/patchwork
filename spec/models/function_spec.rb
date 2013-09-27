require 'spec_helper'

describe Function do
  fixtures(:users)

  it 'caches implementation count' do
    dan      = users(:dan)
    function = dan.functions.create!(:name => 'function', :description => 'description')
    impl     = dan.implementations.create!(:function => function, :source => 'foo')
    function.reload.implementations_count.should == 1
  end
end
