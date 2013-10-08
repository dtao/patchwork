require 'spec_helper'

describe Patch do
  fixtures(:users, :implementations)

  describe '#score' do
    it 'provides the number of upvotes an implementation has received' do
      expect_attribute_change(implementations('chunk/dan'), :score, 2) do |impl|
        create_user!('joe').vote!(impl)
        create_user!('mike').vote!(impl)
      end
    end
  end
end
