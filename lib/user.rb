class User < ActiveRecord::Base
  has_many :reviews
  has_many :carts, through: :reviews

  validates(:username, {:presence => true, :length => {:maximum => 30}, uniqueness: { case_sensitive: false }})
  before_save(:hash_pass)

  # Public method that authenticates passwords
  def auth_pass(password)
    BCrypt::Password.new(self.pass) == password
  end

private
  # Private method called to save the password as a hash pass
  def hash_pass()
    self.pass=(BCrypt::Password.create(pass).to_s)
  end
end
