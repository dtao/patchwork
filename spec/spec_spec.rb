require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'Spec' do
  fixtures(:users)

  it 'caches implementation count' do
    dan  = users(:dan)
    spec = dan.specs.create!(:name => 'spec')
    impl = dan.implementations.create!(:source => 'foo')
    spec.reload.implementations_count.should == 1
  end
end
