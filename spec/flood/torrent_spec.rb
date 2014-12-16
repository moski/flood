describe Flood::Torrent do
  describe '#==' do
    it 'returns true when Torrent Info are the same' do
      torrent = Flood::Torrent.new(info: {a: 1}, announce: 'foo')
      other = Flood::Torrent.new(info: {a: 1}, title: 'foo')
      expect(torrent == other).to be true
    end
    it 'returns false when Torrent Info are different' do
      torrent = Flood::Torrent.new(info: {a: 1})
      other = Flood::Torrent.new(info: {a: 2})
      expect(torrent == other).to be false
    end
    it 'returns false when classes are different' do
      torrent = Flood::Torrent.new(info: {a: 1})
      other = Flood::Identity.new(info: {a: 1})
      expect(torrent == other).to be false
    end
  end

  describe '#created_at' do
    it 'returns a Time when set' do
      torrent = Flood::Torrent.new(info: {a: 1}, "creation date" => Time.now)
      expect(torrent.created_at).to be_a Time
      expect(torrent.created_at).to be_utc
    end
    it 'returns nil when not set' do
      torrent = Flood::Torrent.new(info: {a: 1})
      expect(torrent.created_at).to be_nil
    end
  end
  
  describe '#created?' do
    it 'returns true when created_at is set' do
      torrent = Flood::Torrent.new(info: {a: 1}, "creation date" => Time.now)
      expect(torrent.created?).to be true
    end
    it 'returns false when created_at is not set' do
      torrent = Flood::Torrent.new(info: {a: 1})
      expect(torrent.created?).to be false
    end
  end
  
  describe '#info' do
    it 'returns a Info' do
      torrent = Flood::Torrent.new(info: {a: 1})
      expect(torrent.info).to be_a Flood::MetaInfo
    end
  end
  
end