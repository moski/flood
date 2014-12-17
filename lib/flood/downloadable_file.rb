module Flood
  #
  # Container for the each file embedded within the torrent.
  #
  class DownloadableFile  < Flood::Base
    attr_accessor :name, :length, :start, :finish

    # Initializes a new object
    #
    # @param attrs [Hash]
    # @raise [ArgumentError] Error raised when supplied argument is missing:
    # name   key
    # length key
    # start  key
    # finish key
    # @return [Flood::DownloadableFile]
    def initialize(attrs)
      attrs.fetch(:name)
      attrs.fetch(:length)
      attrs.fetch(:start)
      attrs.fetch(:finish)
      super
    end
  end
end
