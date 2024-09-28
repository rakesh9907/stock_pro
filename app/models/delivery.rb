class Delivery < ApplicationRecord
  belongs_to :stock
  validates :date, uniqueness: { scope: :stock_id, message: 'should have a unique price entry per stock on the same date' }
end
