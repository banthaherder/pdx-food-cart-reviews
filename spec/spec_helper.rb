ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

RSpec.configure do |config|
  config.after(:each) do
    Cart.all().each() do |x|
      x.destroy()
    end
    User.all().each() do |x|
      x.destroy()
    end
    Review.all().each() do |x|
      x.destroy()
    end
  end
end

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }
