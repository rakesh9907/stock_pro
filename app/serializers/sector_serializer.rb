class SectorSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :sector_deliveries
  has_many :industries
end
