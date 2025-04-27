class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, admin: 1, creator: 2 }

  has_many :assets, as: :assetable
end
