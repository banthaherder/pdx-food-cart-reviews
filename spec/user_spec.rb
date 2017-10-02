require "spec_helper"

RSpec.describe(User) do
  it { should have_many :reviews }
  it { should have many :carts }
end
