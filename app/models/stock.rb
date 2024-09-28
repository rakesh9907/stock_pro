class Stock < ApplicationRecord
  belongs_to :industry, dependent: :destroy
  has_many :prices, dependent: :destroy
  has_many :deliveries, dependent: :destroy
  has_many :technicals, dependent: :destroy
end
