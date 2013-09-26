class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :implementation, :counter_cache => :score

  validates_presence_of :user_id
  validates_presence_of :implementation_id
  validates_uniqueness_of :user_id, :scope => :implementation_id

  after_create :update_implementation_user_score

  def update_implementation_user_score
    User.increment_counter(:score, self.implementation.user_id)
  end
end
