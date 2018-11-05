require 'elasticsearch/model'
class ChipseqExperiment < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "CS"
  DEFINITION = "A ChIP-Seq experiment"
  default_scope {order("lower(name)")}
  belongs_to :user
  belongs_to :target
  has_and_belongs_to_many :documents
  # A chipseq_starting_biosamples is one that is the ancestor of one or more 'control_replicates' and 'replicates'.
  has_many :chipseq_starting_biosamples, class_name: "Biosample", foreign_key: :chipseq_starting_biosample_id
  belongs_to :wild_type_control, class_name: "Biosample"
  has_many :control_replicates, -> {controls}, class_name: "Biosample", dependent: :nullify
  has_many :replicates, -> {experimental}, class_name: "Biosample", dependent: :nullify

  accepts_nested_attributes_for :documents, allow_destroy: true

  validates :chipseq_starting_biosample_ids, presence: true
  validates :name, presence: true, uniqueness: true
  validates :target, presence: true

  def self.policy_class
    ApplicationPolicy
  end

  def replicate_ids=(ids)
    """
    Function : Adds associations to biosamples that are stored in self.replicates.
    Args     : ids - array of Biosample IDs.
    """
    ids.each do |i|
      if i.blank?
        next
      end
      rec = Biosample.find(i)
      if not self.replicates.include? rec
        self.replicates << rec
      end
    end
  end

  def document_ids=(ids)
    """
    Function : Adds associations to Documents that are stored in self.documents.
    Args     : ids - array of Document IDs.
    """
    ids.each do |i|
      if i.blank?
        next
      end
      doc = Document.find(i)
      if not self.documents.include? doc
        self.documents << doc
      end
    end
  end
end
