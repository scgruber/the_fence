class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  version :thumb do
    process :resize_to_fill => [50, 50]
  end
  
  def default_url
    "default.png"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
