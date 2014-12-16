describe Flood::DownloadableFile do
  describe '#initialize' do
    it 'raises an IndexError when name/length/start/finish is not specified' do
      expect { Flood::DownloadableFile.new({}) }.to raise_error(IndexError)
    end
  end
end