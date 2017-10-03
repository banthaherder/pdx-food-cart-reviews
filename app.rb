require("bundler/setup")
Bundler.require(:default)
enable :sessions

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @client = GooglePlaces::Client.new('AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I')
  @featured_reviews = Review.all.where("rating >= 4").sample(3)
  erb(:index)
end

get('/cart/:id') do
  @cart = Cart.find(params['id'])
  @reviews = @cart.reviews
  erb(:cart)
end
