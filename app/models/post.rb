require 'uri'

class Post < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many :comments
  validates :title, :presence => true
  # The url validation isn't allowing the url to be updated on posts without urls.
  validate :url_must_be_valid, :on => :create, :if => "url.length > 0"
  validate :url_or_text, :on => :create

  def url_must_be_valid
    unless url.match(URI::regexp)
      errors.add(:url, "must be valid")
    end
  end

  def url_or_text
    if url.strip.length == 0 && text.strip.length == 0
      errors.add(:url, "or text must be entered")
    end
  end

end
