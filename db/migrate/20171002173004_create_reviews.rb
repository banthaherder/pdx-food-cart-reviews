class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table(:reviews) do |t|
      t.column(:cart_id, :integer)
      t.column(:user_id, :integer)
      t.column(:food_name, :string)
      t.column(:price, :string)
      t.column(:rating, :integer)
      t.column(:reported_count, :integer)

      t.timestamp
    end
  end
end
