class Sector < ApplicationRecord
  # add validation name should be unieq
  has_many :industries, dependent: :destroy
  has_many :sector_deliveries, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
