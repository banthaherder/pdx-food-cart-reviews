require("bundler/setup")
Bundler.require(:default)
require("pry")
# sessions provide a way to keep track of who's logged in
enable :sessions

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

# Defines authenticated users that are logged in
helpers do
  def current_user
    if session[:user_id]
      User.find { |u| u.id == session[:user_id] }
    else
      nil
    end
  end
end

get '/sign_in' do
  erb :sign_in
end

post '/sign_in' do
  user = User.find { |u| u.username == params["username"] }
  if user && user.auth_pass(params["pass"])
    # session.clear
    session[:user_id] = user.id
    redirect '/'
  else
    @error = 'Username or password was incorrect'
    binding.pry
    erb :sign_in
  end
end

# TODO ONLY clear a specific user's session
get '/sign_out' do
  session.clear
  redirect back
end

get('/') do
  @featured_reviews = Review.all.where("rating >= 4").sample(3)
  erb(:index)
end

get('/cart') do
  @carts = Cart.all
  erb(:cart)
end

get('/cart/:id') do
  @cart = Cart.find(params[:id])
  @reviews = @cart.reviews
  erb(:cart_reviews)
end

post '/cart/:id' do
  redirect "/cart/#{params["cart"]}"
end

post "/results" do
  redirect "/results/#{params["search"]}"
end


get '/results/:search' do
  @results = GooglePlaces::Client.new('AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I').spots_by_query(params[:search] + ' food cart Portland Oregon')
  erb :results
end

get('/review/:cart_id') do
  if current_user
    @cart = Cart.find(params['cart_id'])
    erb(:new_review)
  else
    redirect '/sign_in'
  end
end

post('/review/:cart_id') do
  if current_user
    Review.create(food_name: params['food'], price: params['price'], review: params['review'], cart_id: params['cart_id'], rating: params['rating'], user_id: current_user.id)
    @cart = Cart.find(params['cart_id'])
    @reviews = @cart.reviews
    @carts = Cart.all
    erb(:cart)
  else
    redirect '/sign_in'
  end
end

get('/review/view/:review_id') do
  @review = Review.find(params['review_id'])
  erb(:review)
end

post '/user' do
  name = params['first_name'] + " " + params['last_name']
  user = User.new(name: name, email: params['email'], username: params['username'], pass: params['password'])
  user.save
  redirect '/'
end
