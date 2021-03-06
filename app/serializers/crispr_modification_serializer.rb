class CrisprModificationSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, 
             :category,
             :description,
             :donor_construct_id,
             :name,
             :notes,
             :purpose,
             :created_at,
             :updated_at,
             :upstream_identifier

  has_one :user

  has_many :biosamples
  has_many :crispr_constructs
  has_many :documents
  has_many :crispr_constructs
end
