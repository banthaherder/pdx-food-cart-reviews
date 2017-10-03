require 'bcrypt'

class Cart < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews
end

class Review < ActiveRecord::Base
  belongs_to :cart
  belongs_to :user
end

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

gyro_cart = Cart.create({:gp_id => "ChIJ6SGO1AUKlVQRdB7wYgNb7HA", :is_confirmed => true, :tag => "Middle Eastern"})
thai_cart = Cart.create({:gp_id => "ChIJKXJu4sRylVQRMqGPudpnMR8", :is_confirmed => true, :tag => "thai"})
dump_cart = Cart.create({gp_id: "ChIJwQw6YgMKlVQRjbynzzv0MN8", :is_confirmed => true, :tag => "Chinese American"})

new_user1 = User.new({:name => "Harry", :username => "bigfoot", :pass => "12345", :email => "test1@test.com", :is_confirmed => true, :is_admin => false})
new_user2 = User.new({:name => "April", :username => "banana", :pass => "12345", :email => "test2@test.com", :is_confirmed => true, :is_admin => true})
new_user1.save
new_user2.save

test_review_1 = Review.create({:cart_id => gyro_cart.id, :user_id => new_user2.id, :food_name => "Gyro", :price => "4.99", :rating => 4, :reported_count => 0, :review => "Friendly family business. One of the best Gyro's I've had."})
test_review_2 = Review.create({:cart_id => gyro_cart.id, :user_id => new_user1.id, :food_name => "Gyro", :price => "5.00", :rating => 2, :reported_count => 0, :review => "Mediocrore lamb and not enough tomatoe."})
test_review_1 = Review.create({:cart_id => thai_cart.id, :user_id => new_user1.id, :food_name => "Yellow Curry", :price => "5.00", :rating => 5, :reported_count => 0, :review => "Some damn good curry."})
test_review_1 = Review.create({:cart_id => dump_cart.id, :user_id => new_user2.id, :food_name => "Mr.Ma's Special", :price => "8.00", :rating => 5, :reported_count => 0, :review => "Super delicious, savory dumplings. Highly recommended!"})
