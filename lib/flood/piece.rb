#
# Container for the each piece within the torrent.
#
module Flood
  class Piece  < Flood::Base
    attr_accessor :index, :start_byte, :end_byte, :piece_hash
    
    # Initializes a new object
    #
    # @param attrs [Hash]
    # @raise [ArgumentError] Error raised when supplied argument is missing a: 
    # index       key
    # start_byte  key
    # end_byte    key
    # piece_hash  key
    # @return [Flood::Piece]
    def initialize(attrs)
      attrs.fetch(:index)
      attrs.fetch(:start_byte)
      attrs.fetch(:end_byte)
      attrs.fetch(:piece_hash)
      super
    end
  end
end