class AlertItem < ApplicationRecord
  belongs_to :stock
  belongs_to :alert
end
