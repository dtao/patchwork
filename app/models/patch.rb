class Patch < ActiveRecord::Base
  belongs_to :user, :counter_cache => true

  has_many :implementations

  LANGUAGES = ['javascript', 'ruby']

  validates_inclusion_of :language, :in => LANGUAGES, :message => "The only supported languages are #{LANGUAGES.to_sentence}"
  validates_presence_of  :name,                       :message => "You must provide a name for the patch."

  strip_attributes

  def each_tag(&block)
    self.tags.split(/,\s*/).each(&block)
  end
end
