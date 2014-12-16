require 'flood/downloadable_file'
require 'flood/piece'

module Flood
  class MetaInfo < Flood::Base
    # @return [Integer]
    attr_reader :length, :piece_length
    
    # @return [String]
    attr_reader :name, :pieces
    
    # @return [Array]
    attr_reader :files, :downloadable_files
    
    def initialize(attrs)
      super      
    end
    
    # Parse the Torrent content for files and pieces
    def parse!
      # populate the downloadable_files array
      set_downloadable_files
      
      # populate the pieces array
      set_pieces
    end
    
    #
    # Check if two torrents are equal if the they have
    # the same info hash.
    # This is called from the Flood.torrent == method.
    # 
    def ==(other)
      self.attrs == other.attrs
    end
    
    #
    # Check if the torrent contains multiple files
    #
    def has_multiple_files?
      !files.nil?
    end
    
    #
    # Get the total size based on the torrent
    # if it's a multi file torrent, then we need to calculate the sun
    # otherwise, get the length for the single file.
    #
    def total_size
      if has_multiple_files?
        calculate_size_from_multiple_files
      else
        calculate_size_from_single_file
      end
    end
    
    #
    # Return the array of files that can be downloaded using
    # this torrent file
    #
    def downloadable_files
      @downloadable_files
    end
    
    #
    # Return an array of all the pieces object within the torrent
    # file
    #
    def pieces_list
      @pieces_list
    end
    
    # 
    # pieces maps to a string whose length is a multiple of 20. 
    # It is to be subdivided into strings of length 20, each of which 
    # is the SHA1 hash of the piece at the corresponding index.
    # @return [integer]
    #
    def number_of_pieces
      pieces.length/20
    end
    
    protected
    
    #
    # For single file, return the length from the information hash
    # @return [integer]
    #
    def calculate_size_from_single_file
      length
    end
    
    #
    # For multi files, return the sum
    #
    def calculate_size_from_multiple_files
      files.inject(0) do |result, file| 
        result + file["length"]
      end
    end
    
    #
    # Based on the torrent type of having on file or multi
    # set the downloadable array
    #
    def set_downloadable_files
      @downloadable_files = []
      
      #
      # If it has multiple files, then loop through them
      # and calculate the offset on each iteration.
      #
      if has_multiple_files?
        files.inject(0) do |offset, file| 
          @downloadable_files << DownloadableFile.new({
            name:   file["path"][0], 
            length: file["length"], 
            start:  offset, 
            finish: offset + file["length"] - 1
          })
          
          # increment the offset for next iteration.
          offset + file["length"]
        end
      else
        @downloadable_files << DownloadableFile.new({
          name: name, 
          length: total_size, 
          start: 0, 
          finish: total_size - 1
        })
      end
    end
    
    #
    # Parse the pieces hash and build pieces object for each
    # defined piece
    #
    def set_pieces
      @pieces_list = []
      (0...number_of_pieces).each do |index|
        #
        # The start byte for each piece is the index of the piece
        # multiplied by the length of each piece.
        # logical, no?
        #
        start_byte = index * piece_length 
        
        #
        # Because we have a fixed piece_length, then the end_piece should equal the start_byte 
        # plus the piece_length.
        # If the piece is the last piece, then it should be at the end of end of file
        #
        end_byte = last_piece?(index) ? (total_size - 1) : (start_byte + piece_length - 1)
        
        #
        # Get the correct SHA1 hash piece information based on the index
        #
        piece_hash = piece_hash(index)
        
        @pieces_list << Piece.new({
          index: index, 
          start_byte: start_byte, 
          end_byte: end_byte, 
          piece_hash: piece_hash})
        
      end
    end
    
    #
    # Check if the piece we are trying to access is the last piece
    # @params index [Integer]
    # @return [Flood::Base]
    #
    def last_piece?(index)
      index == (number_of_pieces - 1)
    end
    
    #
    # pieces maps to a string whose length is a multiple of 20. 
    # It is to be subdivided into strings of length 20, 
    # each of which is the SHA1 hash of the piece at 
    # the corresponding index.
    # @params index [Integer]
    # @return [SHA1 Hash for the piece]
    def piece_hash(index)
      pieces[20 * index...20 * (index+1)]
    end
  end
end 