class User
  has_many :reviews
  has_many :carts, through: :reviews
end
