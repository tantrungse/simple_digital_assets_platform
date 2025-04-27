class CreateAssets < ActiveRecord::Migration[7.1]
  def change
    create_table :assets do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :file_url, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.belongs_to :assetable, polymorphic: true

      t.timestamps
    end
  end
end
