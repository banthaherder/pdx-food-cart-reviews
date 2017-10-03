class Cart < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews
  # AIzaSyAaN83hTHVzlAMvkBd4oc3NGFm4YQ-K71I
  # 'AIzaSyDGlceW7yZG05uKfRqWqTHC3mg8Tlfw54w'

  def name()
    GooglePlaces::Client.new('AIzaSyDGlceW7yZG05uKfRqWqTHC3mg8Tlfw54w').spot(self.gp_id).name
  end

  def hours()
    GooglePlaces::Client.new('AIzaSyDGlceW7yZG05uKfRqWqTHC3mg8Tlfw54w').spot(self.gp_id).opening_hours["weekday_text"][0]
  end
end
