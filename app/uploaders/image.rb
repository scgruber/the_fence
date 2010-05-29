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
