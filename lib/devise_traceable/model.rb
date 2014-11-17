require 'devise_traceable/hooks/traceable'

module Devise
  module Models
    # Trace information about your user sign in. It tracks the following columns:

    # * resource_id
    # * sign_in_at
    # * sign_out_at
    # * ip_address

    module Traceable
      def stamp!
        "#{self.class}Tracing".constantize.create(
          "#{self.class}".foreign_key.to_sym => self.id,
          :sign_in_at => self.current_sign_in_at,
          :sign_out_at => Time.now,
          :ip_address => self.current_sign_in_ip
        )
      end
    end
  end
end
