require "spec_helper"

RSpec.describe(Cart) do
  it { should have_many :reviews }
  it { should have_many :users }
end
