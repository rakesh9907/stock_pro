class Alert < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
