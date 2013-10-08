class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :implementation, :counter_cache => :score

  validate :prevent_cheating

  after_create :update_affected_user_score!

  def prevent_cheating
    if self.user == self.implementation.user
      self.errors << "You aren't allowed to vote for your own implementation."
    end
  end

  def update_affected_user_score!
    User.increment_counter(:score, self.implementation.user)
  end
end
