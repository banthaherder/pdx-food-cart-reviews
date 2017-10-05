class Cart < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews
  # AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I
  # 'AIzaSyDGlceW7yZG05uKfRqWqTHC3mg8Tlfw54w'
  @@client = GooglePlaces::Client.new('AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I')
  before_save(:get_name, :get_hours, :get_photos, :get_phone_number, :get_address, :get_lat, :get_lng)
  def pic()
    # photos.split(",").sample(1).first.fetch_url(800)
    self.photos=(@@client.spot(self.gp_id).photos.sample(1).first.fetch_url(800))
  end

  def average_rating()
    add_rating = 0
    self.reviews.each do |review|
      add_rating += review.rating
    end
    if add_rating != 0
      average_rating = add_rating / self.reviews.length
    else
      average_rating = "No ratings yet"
    end
  end


private
  def get_name()
    self.name=(@@client.spot(self.gp_id).name.to_s)
  end

  def get_hours()
    all_hours = @@client.spot(self.gp_id).opening_hours
    if all_hours != nil
      all_hours["weekday_text"].each do |d|
        d.gsub!("Monday:", "M:")
        d.gsub!("Tuesday:", "T:")
        d.gsub!("Wednesday:", "W:")
        d.gsub!("Thursday:", "TH:")
        d.gsub!("Friday:", "F:")
        d.gsub!("Saturday:", "SAT:")
        d.gsub!("Sunday:", "SUN:")
      end
      self.hours=(all_hours["weekday_text"])
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
