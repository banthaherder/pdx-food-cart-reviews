require("bundler/setup")
Bundler.require(:default)
enable :sessions

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @featured_reviews = Review.all.where("rating >= 4").sample(3)
  erb(:index)
end

get('/cart/:id') do
  @cart = Cart.find(params['id'])
  @reviews = @cart.reviews
  erb(:cart)
end
