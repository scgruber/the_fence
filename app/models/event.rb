class Event
  include Mongoid::Document

  field :name, :type => String
  field :description, :type => String
  field :start, :type => Time
  field :finish, :type => Time
  field :featured, :type => Boolean
  field :cost, :type => Float
  
  attr_accessor :til_whenever # temporary variable
  
  before_validation :blank_out_finish, :if => :til_whenever
  
  references_many :categories, :stored_as => :array
  
  belongs_to_related :creator, :class_name => "User"
  
  # Until HABTM support comes to Mongoid
  # has_one_related :location
  field :location, :type => String
  
  mount_uploader :image, ImageUploader
  validate :image_upload
  
  validate :start_before_finish
  validates_presence_of :start, :name, :description, :location
  validates_presence_of :finish, :unless => :til_whenever
  validates_uniqueness_of :name

  named_scope :happening_now, where(:start.lt => Time.now, :finish.gt => Time.now)
  named_scope :featured, where(:featured => true)
  
  def to_param
    self.id
  end
  
  def duration
    finish ? finish - start : 0
  end
  
  def free?
    cost == 0
  end
  
  def til_whenever?
    !new_record? && finish.nil?
  end
  
  private
  def til_whenever
    # FIXME: A little nasty, can't typecasting fix this?
    @til_whenever == true || @til_whenever == '1'
  end
  
  def start_before_finish
    errors.add(:finish, "should be after start time") if finish && start && finish <= start
  end
  
  def image_upload
    errors.add(:image, "uploads must be a .jpg, .gif, or .png file.") if image_integrity_error
    # errors.add(:image, "failed to be processed") if image_processing_error
  end
  
  def blank_out_finish
    self.finish = nil
  end
end
