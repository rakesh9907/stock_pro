class StockSerializer < ActiveModel::Serializer
  attributes :id, :name, :symbol, :category, :kit_token
end
