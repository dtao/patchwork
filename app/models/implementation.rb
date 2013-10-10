class Implementation < ActiveRecord::Base
  belongs_to :user,  :counter_cache => true
  belongs_to :patch, :counter_cache => true

  has_many :comments, :as => :subject

  validates_presence_of :user_id,  :message => 'You must be logged in to implement a patch.'
  validates_presence_of :patch_id, :message => 'An implementation needs to be associated with a patch.'
  validates_presence_of :source,   :message => "Empty implementations aren't allowed."

  strip_attributes

  def label
    "#{self.patch.name}/#{self.user.name}"
  end
end
