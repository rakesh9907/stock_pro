class Alert < ApplicationRecord
  belongs_to :stock
  belongs_to :price
end
