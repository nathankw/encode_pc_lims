require 'elasticsearch/model'

class SequencingCenter < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "SC"
  DEFINITION = "A facility that sequences your libraries.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  belongs_to :user
  validates :name, uniqueness: true, presence: true, length: { minimum: 2, maximum: 60 }
  validates :address, uniqueness: true, presence: true

  scope :persisted, lambda { where.not(id: nil) }
  
  def self.policy_class
    ApplicationPolicy
  end
end
