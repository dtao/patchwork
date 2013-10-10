class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, :polymorphic => true

  validates_presence_of :user_id,    :message => 'You must be logged in to leave a comment.'
  validates_presence_of :subject_id, :message => 'A comment needs to be related to something.'
  validates_presence_of :content,    :message => 'Empty comments are not allowed.'
end
