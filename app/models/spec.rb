class Spec < ActiveRecord::Base
  TEST_FRAMEWORKS = ['jasmine', 'mocha']

  belongs_to :user

  has_many :implementations
  has_many :comments, :as => :commentable

  validates_presence_of :user_id
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description
  validates_inclusion_of :test_framework, :in => [nil, *TEST_FRAMEWORKS]

  strip_attributes
end
