class IndustryDelivery < ApplicationRecord
  belongs_to :industry
  validates :date, uniqueness: { scope: :industry_id, message: 'should have a unique price entry per stock on the same date' }
end
