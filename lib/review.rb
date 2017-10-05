class Review < ActiveRecord::Base
  belongs_to :cart
  belongs_to :user

  validates(:price, {:presence => true})
  before_save(:format_money, :cap_food_name)


private
  def cap_food_name
    self.food_name=(food_name().split.map!{|word| word.capitalize}.join(' '))
  end
  def format_money
    self.price=(sprintf('%.2f', price()))
  end
end
