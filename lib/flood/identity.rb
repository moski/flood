require 'flood/base'

module Flood
  class Identity < Flood::Base
    # Initializes a new object
    #
    # @param attrs [Hash]
    # @raise [ArgumentError] Error raised when supplied argument is missing an :info key.
    # @return [Flood::Identity]
    def initialize(attrs = {})
      attrs.fetch(:info)
      super
    end
  end
end