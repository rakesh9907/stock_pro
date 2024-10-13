class AlertItem < ApplicationRecord
  belongs_to :stock
  belongs_to :alert

  validates :price, presence: true, uniqueness: true
end
