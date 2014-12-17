require 'time'

module Flood
  #
  # Parse the integer based time from the torrent file
  # and convert it into a Time object.
  # This module expects that @attrs hash contains :creation_date
  #
  module Creatable
    # Time when the torrent was created
    #
    # @return [Time]
    def created_at
      Time.at(@attrs[:creation_date]).utc unless @attrs[:creation_date].nil?
    end

    # @return [Boolean]
    def created?
      !@attrs[:creation_date].nil?
    end
  end
end
