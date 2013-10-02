class Function < ActiveRecord::Base
  belongs_to :user

  has_many :implementations
  has_many :comments, :as => :commentable

  validates_presence_of :user_id
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description

  strip_attributes
end
