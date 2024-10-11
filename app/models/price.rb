class Price < ApplicationRecord
  belongs_to :stock
  has_many :alerts, dependent: :destroy

  validates :date, uniqueness: { scope: :stock_id, message: 'should have a unique price entry per stock on the same date' }
end
