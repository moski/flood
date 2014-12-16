require 'time'

module Flood
  module Creatable
    # Time when the torrent was created
    #
    # @return [Time]
    def created_at
      Time.at(@attrs[:creation_date]).utc unless @attrs[:creation_date].nil?
    end

    # @return [Boolean]
    def created?
      !!@attrs[:creation_date]
    end
  end
end
