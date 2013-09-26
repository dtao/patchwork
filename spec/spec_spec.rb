require File.join(File.dirname(__FILE__), 'spec_helper')

describe Function do
  fixtures(:users)

  it 'caches implementation count' do
    dan      = users(:dan)
    function = dan.functions.create!(:name => 'function')
    impl     = dan.implementations.create!(:source => 'foo')
    function.reload.implementations_count.should == 1
  end
end
