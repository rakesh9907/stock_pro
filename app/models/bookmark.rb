class Bookmark < ApplicationRecord
  has_many :sub_bookmarks, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
