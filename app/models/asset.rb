class Asset < ApplicationRecord
  belongs_to :creator,
             class_name: "User",
             foreign_key: "creator_id",
             inverse_of: :assets
    has_many :purchases,
             dependent: :destroy
    has_many :buyers,
             through: :purchases,
             source: :customer

  validates :title, presence: true
  validates :description, presence: true
  validates :file_url, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  PER_PAGE = 10
end
