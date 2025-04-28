class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, admin: 1, creator: 2 }

  has_many :assets,
           foreign_key: :creator_id,
           dependent: :destroy,
           inverse_of: :creator
  has_many :purchases,
           foreign_key: :customer_id,
           dependent: :destroy
  has_many :purchased_assets,
           through: :purchases,
           source: :asset
end
