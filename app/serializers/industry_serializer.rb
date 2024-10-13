class IndustrySerializer < ActiveModel::Serializer
  attributes :id, :name, :sector
  has_many :stocks
  has_many :industry_deliveries

  def sector
    object.sector.name
  end
end