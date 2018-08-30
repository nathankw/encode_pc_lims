class GelSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, 
             :caption,
             :gel_image,
             :notes,
             :percentage,
             :run_date
             :voltage

  has_one :immunoblot
  has_one :user
end
