require 'carrierwave/orm/mongoid'

CarrierWave.configure do |config| # TODO test me
  config.storage = :grid_fs
  config.grid_fs_database = Mongoid.database.name
  config.grid_fs_host = Mongoid.config.master.connection.host
  config.grid_fs_access_url = "/images"
end