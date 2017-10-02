class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table(:users) do |t|
      t.column(:name, :string)
      t.column(:username, :string)
      t.column(:pass, :string)
      t.column(:email, :string)
      t.column(:is_confirmed, :boolean)
      t.column(:is_admin, :boolean)

      t.timestamp
    end
  end
end
