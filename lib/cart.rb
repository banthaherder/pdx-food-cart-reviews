class Cart < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews
  # AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I
  # 'AIzaSyDGlceW7yZG05uKfRqWqTHC3mg8Tlfw54w'

  before_save(:get_name, :get_hours, :get_photos, :get_phone_number, :get_address)

  def pic()
    # photos.split(",").sample(1).first.fetch_url(800)
    self.photos=(GooglePlaces::Client.new('AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I').spot(self.gp_id).photos.sample(1).first.fetch_url(800))
  end

private
  def get_name()
    self.name=(GooglePlaces::Client.new('AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I').spot(self.gp_id).name.to_s)
  end

  def get_hours()
    self.hours=(GooglePlaces::Client.new('AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I').spot(self.gp_id).opening_hours["weekday_text"])
  end

  def get_photos()
    self.photos=(GooglePlaces::Client.new('AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I').spot(self.gp_id).photos)
  end

  def get_phone_number()
    self.phone_number=(GooglePlaces::Client.new('AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I').spot(self.gp_id).formatted_phone_number)
  end

  def get_address()
    self.address=(GooglePlaces::Client.new('AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I').spot(self.gp_id).formatted_address)
  end
end
