class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases do |t|
      t.references :customer, null: false, foreign_key: { to_table: :users }
      t.references :asset,    null: false, foreign_key: true

      t.timestamps
    end

    add_index :purchases, [:customer_id, :asset_id], unique: true
  end
end
