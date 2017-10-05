require 'bcrypt'
require 'google_places'
class Cart < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews
  # AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I
  # 'AIzaSyDGlceW7yZG05uKfRqWqTHC3mg8Tlfw54w'
  @@client = GooglePlaces::Client.new('AIzaSyDGlceW7yZG05uKfRqWqTHC3mg8Tlfw54w')
  before_save(:get_name, :get_hours, :get_photos, :get_phone_number, :get_address, :get_lat, :get_lng)
  def pic()
    # photos.split(",").sample(1).first.fetch_url(800)
    self.photos=(@@client.spot(self.gp_id).photos.sample(1).first.fetch_url(800))
  end

private
  def get_name()
    self.name=(@@client.spot(self.gp_id).name.to_s)
  end

  def get_hours()
    if @@client.spot(self.gp_id).opening_hours != nil
      self.hours=(@@client.spot(self.gp_id).opening_hours["weekday_text"])
    else
      self.hours=(["Business hours not provided."])
    end
  end

  def get_photos()
    self.photos=(@@client.spot(self.gp_id).photos)
  end

  def get_phone_number()
    self.phone_number=(@@client.spot(self.gp_id).formatted_phone_number)
  end

  def get_address()
    self.address=(@@client.spot(self.gp_id).formatted_address)
  end

  def get_lat()
    self.lat=(@@client.spot(self.gp_id).lat)
  end

  def get_lng()
    self.lng=(@@client.spot(self.gp_id).lng)
  end
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

Cart.destroy_all
User.destroy_all
Review.destroy_all

gyro_cart = Cart.new({:gp_id => "ChIJ6SGO1AUKlVQRdB7wYgNb7HA", :is_confirmed => true, :tag => "Middle Eastern", :name => nil, :phone_number => nil, :address => nil, :photos => nil, :hours => nil})
thai_cart = Cart.new({:gp_id => "ChIJKXJu4sRylVQRMqGPudpnMR8", :is_confirmed => true, :tag => "thai"})
dump_cart = Cart.new({gp_id: "ChIJwQw6YgMKlVQRjbynzzv0MN8", :is_confirmed => true, :tag => "Chinese American"})
gyro_cart.save
thai_cart.save
dump_cart.save

new_user1 = User.new({:name => "Harry", :username => "bigfoot", :pass => "12345", :email => "test1@test.com", :is_confirmed => true, :is_admin => false})
new_user2 = User.new({:name => "April", :username => "banana", :pass => "12345", :email => "test2@test.com", :is_confirmed => true, :is_admin => true})
new_user1.save
new_user2.save

test_review_1 = Review.create({:cart_id => gyro_cart.id, :user_id => new_user2.id, :food_name => "Gyro", :price => "4.99", :rating => 4, :reported_count => 0, :review => "Friendly family business. One of the best Gyro's I've had."})
test_review_2 = Review.create({:cart_id => gyro_cart.id, :user_id => new_user1.id, :food_name => "Gyro", :price => "5.00", :rating => 2, :reported_count => 0, :review => "Mediocrore lamb and not enough tomatoe."})
test_review_1 = Review.create({:cart_id => thai_cart.id, :user_id => new_user1.id, :food_name => "Yellow Curry", :price => "5.00", :rating => 5, :reported_count => 0, :review => "Some damn good curry."})
test_review_1 = Review.create({:cart_id => dump_cart.id, :user_id => new_user2.id, :food_name => "Mr.Ma's Special", :price => "8.00", :rating => 5, :reported_count => 0, :review => "Super delicious, savory dumplings. Highly recommended!"})
