require "spec_helper"

RSpec.describe(User) do
  it { should have_many :reviews }
  it { should have_many :carts }
end
