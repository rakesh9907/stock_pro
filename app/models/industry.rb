class Industry < ApplicationRecord
  belongs_to :sector
  has_many :stocks 
  has_many :industry_deliveries, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
