class Implementation < ActiveRecord::Base
  belongs_to :user,  :counter_cache => true
  belongs_to :patch, :counter_cache => true

  validates_presence_of :source, :message => "Empty implementations aren't allowed."

  strip_attributes
end
