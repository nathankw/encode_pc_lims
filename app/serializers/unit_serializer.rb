class UnitSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, 
             :name, 
             :unit_type,
             :created_at, 
             :updated_at

  has_one :user
end
