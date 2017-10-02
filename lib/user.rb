class User < ActiveRecord::Base
  has_many :reviews
  has_many :carts, through: :reviews

  before_save(:hash_pass)

  # Public method that authenticates passwords
  def auth_pass(password)
    BCrypt::Password.create(password) == self.hash_pass
  end

private
  # Private method called to save the password as a hash pass
  def hash_pass()
    self.pass=(BCrypt::Password.create(pass).to_s)
  end
end
