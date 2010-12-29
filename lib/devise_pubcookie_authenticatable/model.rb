module Devise
  module Models
    module PubcookieAuthenticatable
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def find_by_pubcookie_username(username)
          find(:first, :conditions => {:pubcookie_username => username})
        end
      end
    end
  end
end
