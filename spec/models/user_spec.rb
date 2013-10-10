require 'spec_helper'

describe User do
  fixtures(:users, :patches, :implementations)

  let(:required_attributes) do
    {
      :name => 'Joe Schmoe',
      :email => 'joe.schmoe@example.com',
      :password => 'horsey',
      :password_confirmation => 'horsey'
    }
  end

  describe '#vote!' do
    it 'prevents a user from voting for his/her own implementation' do
      expect_exception(ActiveRecord::ActiveRecordError) do
        users(:dan).vote!(implementations('chunk/dan'))
      end
    end

    it 'prevents a user from voting for the same implementation twice' do
      users(:adam).vote!(implementations('chunk/dan'))
      expect_exception(ActiveRecord::ActiveRecordError) do
        users(:adam).vote!(implementations('chunk/dan'))
      end
    end
  end

  describe '#already_voted_for?' do
    it 'indicates whether a user has already voted for an implementation' do
      joe   = create_user!('joe')
      chunk = implementations('chunk/dan')

      joe.already_voted_for?(chunk).should be_false

      joe.vote!(chunk)
      joe.already_voted_for?(chunk).should be_true
    end
  end

  describe '#patches_count' do
    it 'provides the number of patches a user has defined' do
      expect_attribute_change(users(:dan), :patches_count) do |dan|
        dan.patches.create!(:name => 'extend', :language => 'javascript')
      end
    end
  end

  describe '#implementations_count' do
    it 'provides the number of implementations a user has written' do
      expect_attribute_change(users(:dan), :implementations_count) do |dan|
        dan.implementations.create!(:patch => patches(:chunk), :source => 'foo')
      end
    end
  end

  describe '#score' do
    it 'provides the number of votes a user has received for his/her implementations' do
      expect_attribute_change(users(:dan), :score, 2) do |dan|
        create_user!('joe').vote!(implementations('chunk/dan'))
        create_user!('sam').vote!(implementations('chunk/dan'))
      end
    end
  end
end
