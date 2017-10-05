class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table(:carts) do |t|
      t.column(:tag, :string)
      t.column(:gp_id, :string)
      t.column(:is_confirmed, :boolean)
      t.column(:name, :string)
      t.column(:hours, :string)
      t.column(:photos, :string)
      t.column(:phone_number, :string)
      t.column(:address, :string)
      t.column(:lat, :string)
      t.column(:lng, :string)

      t.timestamps
    end
  end
end
