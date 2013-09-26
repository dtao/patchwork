class Implementation < ActiveRecord::Base
  belongs_to :user
  belongs_to :function, :counter_cache => true

  has_many :votes
  has_many :comments, :as => :commentable

  validates_presence_of :user_id
  validates_presence_of :function_id

  strip_attributes
end
