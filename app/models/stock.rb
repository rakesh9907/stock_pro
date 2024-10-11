class Stock < ApplicationRecord
  belongs_to :industry, dependent: :destroy
  has_many :prices, dependent: :destroy
  has_many :deliveries, dependent: :destroy
  has_many :technicals, dependent: :destroy
  has_many :alerts, dependent: :destroy
  validates :symbol, presence: true, uniqueness: true
end
