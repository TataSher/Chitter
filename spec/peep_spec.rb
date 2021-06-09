require 'peep'
require 'setup_test_database'
require 'database_helpers'

describe 'Peep' do
  describe '#list' do
    it 'returns all peeps as Peep instances' do
      peep1 = Peep.create(peep: 'First Peep')
      peep2 = Peep.create(peep: 'Second Peep')
      peep3 = Peep.create(peep: 'Third Peep')
      peeps = Peep.list
      
      expect(peeps.length).to eq(3)
      expect(peeps.first).to be_a Peep
      expect(peeps.first.id).to eq peep1.id
      expect(peeps.first.peep).to eq peep1.peep
    end
  end
end