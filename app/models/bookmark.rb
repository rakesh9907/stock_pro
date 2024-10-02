class Bookmark < ApplicationRecord
  has_many :sub_bookmarks, dependent: :destroy
end
