describe Flood::Identity do

  describe '#initialize' do
    it 'raises an IndexError when info is not specified' do
      expect { Flood::Identity.new }.to raise_error(IndexError)
    end
  end
end