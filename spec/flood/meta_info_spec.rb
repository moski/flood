describe Flood::Torrent do
  describe '#==' do
    it 'returns true when attrs are the same' do
      info = Flood::MetaInfo.new(a: 1)
      other = Flood::MetaInfo.new(a: 1)
      expect(info == other).to be true
    end
    
    it 'returns false when Torrent Info are different' do
      info = Flood::MetaInfo.new(a: 1)
      other = Flood::MetaInfo.new(b: 2)
      expect(info == other).to be false
    end
  end
  
  describe "#has_multiple_files?" do
    it "should return true if the torrent has multiple file set" do
      info = BEncode::Parser.new(File.open(File.join(fixture_path, "caro_emerald.torrent"))).parse!["info"]
      meta = Flood::MetaInfo.new(info)      
      expect(meta.has_multiple_files?).to be true
    end
    
    it "should return false if the torrent is a single file only" do
      info = BEncode::Parser.new(File.open(File.join(fixture_path, "torrent1.torrent"))).parse!["info"]
      meta = Flood::MetaInfo.new(info)
      expect(meta.has_multiple_files?).to be false
    end
  end
  
  describe "#total_size" do
    it "should return the size for the single file" do
      info = BEncode::Parser.new(File.open(File.join(fixture_path, "torrent1.torrent"))).parse!["info"]
      meta = Flood::MetaInfo.new(info)
      expect(meta.total_size).to be 905250687
    end
  
    it "should return the sum of file sizes in multi file torrent" do
      info = BEncode::Parser.new(File.open(File.join(fixture_path, "caro_emerald.torrent"))).parse!["info"]
      meta = Flood::MetaInfo.new(info)      
      expect(meta.total_size).to be 295407736
    end
  end
  
  describe "#downloadable_files" do
    it "should return one file for a single file torrent" do
      info = BEncode::Parser.new(File.open(File.join(fixture_path, "torrent1.torrent"))).parse!["info"]
      meta = Flood::MetaInfo.new(info)
      meta.parse!
      expect(meta.downloadable_files.size).to be 1
    end
    
    it "should return more than one file for a multi file torrent" do
      info = BEncode::Parser.new(File.open(File.join(fixture_path, "caro_emerald.torrent"))).parse!["info"]
      meta = Flood::MetaInfo.new(info)
      meta.parse!
      expect(meta.downloadable_files.size).to be 12
    end
  end
  
  describe "#number_of_pieces" do
    it "should be the length of pieces divided by 20" do
      info = BEncode::Parser.new(File.open(File.join(fixture_path, "caro_emerald.torrent"))).parse!["info"]
      meta = Flood::MetaInfo.new(info)
      meta.parse!
      expect(meta.number_of_pieces).to be (meta.pieces.length/20)
    end
  end
  
  describe "#pieces_list" do
    before do
      info = BEncode::Parser.new(File.open(File.join(fixture_path, "caro_emerald.torrent"))).parse!["info"]
      @meta = Flood::MetaInfo.new(info)
      @meta.parse!
    end
    
    it "should return an array of all the pieces" do
      expect(@meta.pieces_list).to be_an Array
    end
    
    it "return an array of Piece objects" do
      expect(@meta.pieces_list.first).to be_a Flood::Piece
    end
    
    it "return an array with the correct size" do
      expect(@meta.pieces_list.size).to be 564
    end
  end
end