class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :implementation, :counter_cache => :score

  validate :prevent_cheating, :prevent_duplicate_votes

  after_create :update_affected_user_score!

  protected

  def prevent_cheating
    if self.user == self.implementation.user
      self.errors.add(:user_id, "You aren't allowed to vote for your own implementation.")
    end
  end

  def prevent_duplicate_votes
    if self.user.already_voted_for?(self.implementation_id)
      self.errors.add(:user_id, "You can't vote for the same implementation twice.")
    end
  end

  def update_affected_user_score!
    User.increment_counter(:score, self.implementation.user)
  end
end
