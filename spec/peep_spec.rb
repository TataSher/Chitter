require 'peep'

describe 'Peep' do
  describe '#list' do
    it 'returns all peeps' do
      peeps = Peep.list

      expect(peeps).to include('First Peep')
      expect(peeps).to include('Second Peep')
      expect(peeps).to include('Third Peep')
    end
  end
  describe '#create' do
    it 'creates peeps' do
      Peep.create('Fourth Peep')

      expect(Peep.list).to include('Fourth Peep')
    end
  end
end