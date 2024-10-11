class StockSerializer < ActiveModel::Serializer
  attributes :id, :name, :symbol
end
