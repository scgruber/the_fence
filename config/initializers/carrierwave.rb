require 'carrierwave/orm/mongoid'

CarrierWave.configure do |config| # TODO test me
  config.grid_fs_access_url = "/images"
end