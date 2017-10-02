require "spec_helper"

RSpec.describe(User) do
  it { should have_many :reviews }
  it { should have_many :carts }

  it "will create a user with a hashed password" do
    new_user = User.create({:name => "Javi", :username => "chinchilla", :pass => "iluvchinchillas", :email => "javierrcc522@gmail.com", :is_admin => true})

    expect(new_user.name).to eq("Javi")
  end
end
