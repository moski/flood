describe Flood::Piece do
  describe '#initialize' do
    it 'raises an IndexError when index/start_byte/end_byte/hash is not specified' do
      expect { Flood::Piece.new({}) }.to raise_error(IndexError)
    end
  end
end