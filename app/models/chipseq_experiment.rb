require 'elasticsearch/model'
class ChipseqExperiment < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "CS"
  DEFINITION = "A ChIP-seq experiment"
  #default_scope {order("lower(name)")}
  belongs_to :user
  belongs_to :target
  has_and_belongs_to_many :documents
  # A chipseq_starting_biosamples is one that is the ancestor of one or more 'control_replicates' and 'replicates'.
  has_many :chipseq_starting_biosamples, class_name: "Biosample", foreign_key: :chipseq_starting_biosample_id, dependent: :nullify
  belongs_to :wild_type_control, class_name: "Biosample"
  has_many :control_replicates, -> {controls}, class_name: "Library", dependent: :nullify
  has_many :replicates, -> {experimental}, class_name: "Library", dependent: :nullify

  accepts_nested_attributes_for :documents, allow_destroy: true

  #validates :chipseq_starting_biosample_ids, presence: true
  validates :name, presence: true, uniqueness: true
  validates :target, presence: true

  def self.policy_class
    ApplicationPolicy
  end

  def paired_input_control_map
    # Generates a hash where each key is an ID of an experimental Biosample record and each value is a
    # list of one or more control Biosample record IDs, where each control is derived from the experimental
    # Biosample via either the part_of attribute or the pooled_from_biosamples attribute. 
    # Experimental Biosamples that don't have controls don't appear in the hash. 
    res = {}
    self.control_replicates.each do |ctl_lib|
      ctl_bio = ctl_lib.biosample
      self.replicate_ids.each do |exp_lib_id|
        exp_bio_id = Library.find(exp_lib_id).biosample.id
        if ctl_bio.parent_ids.include?(exp_bio_id)
          if not res.include?(exp_bio_id)
            res[exp_bio_id] = []
          end
          res[exp_bio_id] << ctl_bio.id
        end
      end
    end
    return res
  end

  def replicate_ids=(ids)
    """
    Function : Adds associations to Libraries that are stored in self.replicates.
    Args     : ids - array of Library IDs.
    """
    ids.each do |i|
      if i.blank?
        next
      end
      rec = Library.find(i)
      if not self.replicates.include? rec
        self.replicates << rec
      end
    end
  end

  def control_replicate_ids=(ids)
    """
    Function : Adds associations to Libraries that are stored in self.control_replicates.
    Args     : ids - array of Library IDs.
    """
    ids.each do |i|
      if i.blank?
        next
      end
      rec = Library.find(i)
      if not self.control_replicates.include? rec
        self.control_replicates << rec
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
