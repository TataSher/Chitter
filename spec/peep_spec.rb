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
  describe '#create' do
    it 'creates peeps' do
      add_peeps
      peep = Peep.create(peep: 'Fourth Peep')
      persisted_data = persisted_data(id: peep.id)

      expect(peep).to be_a Peep
      expect(peep.id).to eq persisted_data['id']
      expect(peep.peep).to eq persisted_data['peep']
    end
  end
  describe '#delete' do
    it 'deletes peeps' do
      peep = Peep.create(peep: 'First Peep')

      Peep.delete(id: peep.id )

      expect(Peep.list.length).to eq(0)
    end
  end
  describe '#update' do
    it 'updates peeps' do
      peep = Peep.create(peep: 'First Peep')
      updated_peep = Peep.update(id: peep.id, peep: 'Amended')

      expect(updated_peep).to be_a Peep
      expect(updated_peep.id).to eq peep.id
      expect(updated_peep.peep).to eq('Amended')
    end
  end
end