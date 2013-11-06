class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  validates :username, :uniqueness => true
  validates :username, :presence => true
  validates :password, :presence => true

  def self.exists?(username)
    user = User.find_by_username(username)
    !user.nil?
  end

  def self.authenticate(username, password)
    User.find_by_username_and_password(username, password)
  end

end
