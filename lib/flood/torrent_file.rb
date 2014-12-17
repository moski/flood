require 'bencode'

module Flood
  # Parse the Torrent File for information
  class TorrentFile
    def self.load!(torrent_file)
      BEncode::Parser.new(File.open(torrent_file)).parse!
    end
  end
end
