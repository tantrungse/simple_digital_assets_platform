class Asset < ApplicationRecord
  belongs_to :assetable, polymorphic: true

  validates :title, presence: true
  validates :description, presence: true
  validates :file_url, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  PER_PAGE = 10
end
