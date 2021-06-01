require 'peeps'

describe 'Peep' do
  describe 'list' do
    it 'returns all peeps' do
      peeps = Peep.list

      expect(peeps).to include('First Peep')
      expect(peeps).to include('Second Peep')
      expect(peeps).to include('Third Peep')
    end
  end
end