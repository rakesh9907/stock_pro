class SectorDelivery < ApplicationRecord
  belongs_to :sector
  validates :date, uniqueness: { scope: :sector_id, message: 'should have a unique price entry per stock on the same date' }
end
