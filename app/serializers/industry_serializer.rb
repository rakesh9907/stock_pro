class IndustrySerializer < ActiveModel::Serializer
  attributes :id, :name, :sector
  has_many :stocks

  def sector
    object.sector.name
  end
end