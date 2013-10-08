require 'spec_helper'

describe Patch do
  fixtures(:users, :patches)

  describe '#implementations_count' do
    it 'provides the number of implementations a user has written' do
      expect_attribute_change(patches(:chunk), :implementations_count) do |chunk|
        users(:dan).implementations.create!(:patch => chunk, :source => 'foo')
      end
    end
  end
end
