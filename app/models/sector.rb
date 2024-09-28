class Sector < ApplicationRecord
  has_many :industries, dependent: :destroy
  has_many :sector_deliveries, dependent: :destroy
end
