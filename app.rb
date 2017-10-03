require("bundler/setup")
Bundler.require(:default)
enable :sessions

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @featured_reviews = Review.all.where("rating >= 4").sample(3)
  erb(:index)
end

get('/cart') do
  @carts = Cart.all
  erb(:cart)
end

get('/cart/:id') do
  @cart = Cart.find(params['id'])
  @reviews = @cart.reviews
  erb(:cart_reviews)
end

get('/review/:cart_id') do
  @cart = Cart.find(params['cart_id'])
  erb(:new_review)
end

post('/review/:cart_id') do
  Review.create(food_name: params['food'], price: params['price'], review: params['review'], cart_id: params['cart_id'], rating: params['rating'])
  @cart = Cart.find(params['cart_id'])
  @reviews = @cart.reviews
  erb(:cart)
end
