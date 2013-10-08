class User < ActiveRecord::Base
  include Gravtastic

  has_many :patches
  has_many :implementations
  has_many :votes

  has_secure_password
  has_gravatar

  validates_presence_of   :name,  :message => "You must provide a name."
  validates_presence_of   :email, :message => "You must provide an e-mail address."
  validates_uniqueness_of :email, :message => "A user with that e-mail address already exists."

  strip_attributes

  def vote!(implementation)
    self.votes.create!(:implementation => implementation)
  end
end
