# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::ImageScience

  storage :grid_fs

  version :thumb do
    process :scale => [50, 50]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
