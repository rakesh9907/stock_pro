class SectorSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :industries
end
