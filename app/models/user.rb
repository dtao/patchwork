class User < ActiveRecord::Base
  include Gravtastic

  has_gravatar
  has_secure_password

  has_many :specs
  has_many :implementations
  has_many :comments

  validates_presence_of :user_name
  validates_uniqueness_of :user_name
  validates_presence_of :real_name
  validates_presence_of :email

  strip_attributes
end
