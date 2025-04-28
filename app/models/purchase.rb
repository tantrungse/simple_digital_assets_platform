class Purchase < ApplicationRecord
  belongs_to :customer,
             class_name: "User",
             foreign_key: "customer_id",
             inverse_of: :purchases
  belongs_to :asset

  validates :asset_id,
            uniqueness: { scope: :customer_id, message: "already purchased" }
end
