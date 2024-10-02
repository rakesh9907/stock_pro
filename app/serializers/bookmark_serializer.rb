class BookmarkSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :sub_bookmarks
end
