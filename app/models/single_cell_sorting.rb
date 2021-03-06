require 'elasticsearch/model'

class SingleCellSorting < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "SCS"
  DEFINITION = "Any single cell sorting type of experiment that results in one or more Plates, where each well on a plate contains a single cell. This can be used in the context of scATAC-Seq, or scRNA-Seq, for example.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  belongs_to :library_prototype, class_name: "Library", dependent: :destroy
  #the library_prototype is used as a template for creating library objects for each biosample in each well of each plate.
  belongs_to :sorting_biosample, class_name: "Biosample", dependent: :destroy
  belongs_to :starting_biosample, class_name: "Biosample"
  belongs_to :user
  has_many :analyses, dependent: :destroy
  has_many :plates, dependent: :destroy
  has_many :sequencing_requests, through: :plates
  has_and_belongs_to_many :documents

  validates  :upstream_identifier, uniqueness: true, allow_blank: true
  validates :name, presence: true, uniqueness: true
  validates :starting_biosample, presence: true #single cell sorting exp. must start with a biosample having cells to sort.

  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :sorting_biosample, allow_destroy: true
  accepts_nested_attributes_for :plates, allow_destroy: true
  accepts_nested_attributes_for :library_prototype, allow_destroy: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def s3_direct_post                                                                                   
    # Used for getting a bucket object URI for uploading a gel image.                                  
    # Called in the controller via a private method with the same name.                                
    return S3_BUCKET.presigned_post(key: "fluorescence_intensity/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
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

  def input_reads_selection_for_analysis
    input_reads = [] # A list of SequencingResult objects to be used as the selection list for        
                         # when choosing a value for Analysis.input_reads.                             
    self.sequencing_requests.each do |sreq|                                            
      sreq.sequencing_runs.each do |srun|                                                              
        srun.sequencing_results.each do |sres|                                                         
          input_reads << sres                                                                       
        end                                                                                            
      end                                                                                              
    end 
    return input_reads
  end
end
