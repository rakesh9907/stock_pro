class StockSerializer < ActiveModel::Serializer
  attributes :id, :name, :symbol, :category
end
