describe Flood::TorrentFile do
  before do
    @good_file = File.join(fixture_path, 'torrent1.torrent')
    @bad_file = File.join(fixture_path, 'moski.png')
  end

  describe 'load!' do
    it 'Load and parse the content of the torrent file' do
      torrent_info = Flood::TorrentFile.load!(@good_file)
      expect(torrent_info).to be_a Hash
    end

    it 'Should throw an exception when the file is not a valid torrent file' do
      torrent_info = Flood::TorrentFile.load!(@bad_file)
      expect(torrent_info).to be nil
    end
  end
end
