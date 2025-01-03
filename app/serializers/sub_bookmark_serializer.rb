class SubBookmarkSerializer < ActiveModel::Serializer
  attributes :id, :added_price, :added_date
  belongs_to :stock
end
