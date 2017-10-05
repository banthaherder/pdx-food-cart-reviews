require "spec_helper"

RSpec.describe(Cart) do
  it { should have_many :reviews }
  it { should have_many :users }

  it "will add up all reviews to achieve an average" do
    cart = Cart.new({:gp_id => "ChIJ6SGO1AUKlVQRdB7wYgNb7HA", :is_confirmed => true, :tag => "Middle Eastern", :name => nil, :phone_number => nil, :address => nil, :photos => nil, :hours => nil})
    cart.save
    new_user1 = User.new({:name => "Harry", :username => "bigfoot", :pass => "12345", :email => "test1@test.com", :is_confirmed => true, :is_admin => false})
    new_user2 = User.new({:name => "Harry123", :username => "bigfoot123", :pass => "12345", :email => "test1@test.com", :is_confirmed => true, :is_admin => false})

    test_review_1 = Review.create({:cart_id => cart.id, :user_id => new_user1.id, :food_name => "Gyro", :price => "4.99", :rating => 5, :reported_count => 0, :review => "Blah blah blah"})
    test_review_2 = Review.create({:cart_id => cart.id, :user_id => new_user2.id, :food_name => "Gyro", :price => "4.99", :rating => 3, :reported_count => 0, :review => "Blah blah blah"})

    # (3 + 5) / 2 = 4
    expect(cart.average_rating).to eq 4
  end
end
