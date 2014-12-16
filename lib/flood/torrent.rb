require 'flood/creatable'
require 'flood/meta_info'

#
# Parse the Torrent File for information
#
# @attrs usually looks like this:
# ["announce", "announce-list", "comment", "created by", "creation date", "encoding", "info"]
#
module Flood
  class Torrent < Flood::Identity
    #
    # Parse the created_at into a time format.
    #
    include Flood::Creatable

    #
    # Every torrent file contains the following fields:
    #
    attr_reader :announce, :comment
    
    #
    # Create a MetaInfo from the info hash
    #
    object_attr_reader :MetaInfo, :info

    #
    # Override the == to check meta information class.
    #
    def ==(other)
      self.info == other.info rescue false
    end
  end
end