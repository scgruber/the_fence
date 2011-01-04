class Event
  include Mongoid::Document

  field :name, :type => String
  field :description, :type => String
  field :start, :type => Time
  field :finish, :type => Time
  field :til_whenever, :type => Boolean
  field :cost
  field :free, :type => Boolean
  
  field :featured, :type => Boolean
  field :page_rank, :type => Integer, :default => 0
  
  before_validation :blank_out_finish, :if => :til_whenever?
  before_validation :blank_out_cost, :if => :free?
  
  references_many :categories, :stored_as => :array, :inverse_of => :events
  
  belongs_to_related :creator, :class_name => "User"
  
  # FIXME: replace with mongoid HABTM support
  # has_one_related :location
  field :location, :type => String
  
  mount_uploader :image, ImageUploader
  validate :image_upload
  
  validate :start_before_finish
  validates_presence_of :start, :name, :description, :location
  validates_presence_of :finish, :unless => :til_whenever
  validates_uniqueness_of :name

  scope :happening_now, where(:start.lt => Time.now, :finish.gt => Time.now)
  scope :featured, where(:featured => true).descending(:page_rank)
  scope :upcoming, where(:start.gt => Time.now)
  
  def to_param
    self.id
  end
  
  def duration
    finish ? finish - start : 0
  end
  
  private
  def start_before_finish
    errors.add(:finish, I18n.t('events.validations.finish_after_start')) if finish && start && finish <= start
  end
  
  def image_upload
    errors.add(:image, I18n.t('events.validations.image_file_type')) if image_integrity_error    
  end
  
  def blank_out_finish
    self.finish = nil
  end
  
  def blank_out_cost
    self.cost = nil
  end
end
