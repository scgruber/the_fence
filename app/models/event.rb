class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :grid_fs

  # version :thumb do
  #   process :scale => [50, 50]
  # end
  
  def default_url
    "default.png"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end


class Event
  include Mongoid::Document

  field :name, :type => String
  field :description, :type => String
  field :start, :type => Time
  field :finish, :type => Time
  field :featured, :type => Boolean
  field :cost, :type => Float
  
  has_many_related :categories
  
  # Until HABTM support comes to Mongoid
  # has_one_related :location
  field :location, :type => String
  
  mount_uploader :image, ImageUploader
  validate :image_upload
  
  validate :start_before_finish
  validates_presence_of :start, :name, :description, :location
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
    finish.nil?
  end
  
  private
  def start_before_finish
    errors.add(:finish, "should be after start time") if finish && start && finish <= start
  end
  
  def image_upload
    errors.add(:image, "uploads must be a .jpg, .gif, or .png file.") if image_integrity_error
    # errors.add(:image, "failed to be processed") if image_processing_error
  end
end
