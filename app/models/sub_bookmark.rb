class SubBookmark < ApplicationRecord
  belongs_to :bookmark, dependent: :destroy
  belongs_to :stock
end
