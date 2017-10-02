class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table(:carts) do |t|
      t.column(:tag, :string)
      t.column(:gp_id, :string)
      t.column(:is_confirmed, :boolean)

      t.timestamp
    end
  end
end
