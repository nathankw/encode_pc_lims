class DocumentTypeSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :name, :user_id, :updated_at, :created_at
end