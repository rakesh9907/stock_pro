class AlertSerializer < ActiveModel::Serializer
  attributes :id
  has_many :alert_items
end
