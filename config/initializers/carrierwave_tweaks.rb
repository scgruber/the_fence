# Made pull request
# http://github.com/maxhawkins/carrierwave

module CarrierWave
  module Test
    module Matchers
      class ImageLoader # :nodoc:
        def self.load_image(filename)
          if defined? ::MiniMagick
            MiniMagickWrapper.new(filename)
          else
            unless defined? ::Magick
              begin
                require 'rmagick'
              rescue LoadError
                require 'RMagick'
              rescue LoadError
                puts "WARNING: Failed to require rmagick, image processing may fail!"
              end
            end
            MagickWrapper.new(filename)
          end
        end
      end
    end
  end
end