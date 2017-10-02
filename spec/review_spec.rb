require "spec_helper"

RSpec.describe(Review) do
  it { should belong_to(:user) }
  it { should belong_to(:cart)}
end
