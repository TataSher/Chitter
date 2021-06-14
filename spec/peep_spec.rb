require 'peep'
require 'setup_test_database'
require 'database_helpers'

describe 'Peep' do
  describe '.list' do
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
  describe '.create' do
    it 'creates peeps' do
      add_peeps
      peep = Peep.create(peep: 'Fourth Peep')
      persisted_data = persisted_data(table: 'peeps', id: peep.id)

      expect(peep).to be_a Peep
      expect(peep.id).to eq persisted_data.first['id']
      expect(peep.peep).to eq persisted_data.first['peep']
    end
  end
  describe '.delete' do
    it 'deletes peeps' do
      peep = Peep.create(peep: 'First Peep')

      Peep.delete(id: peep.id )

      expect(Peep.list.length).to eq(0)
    end
  end
  describe '.update' do
    it 'updates peeps' do
      peep = Peep.create(peep: 'First Peep')
      updated_peep = Peep.update(id: peep.id, peep: 'Amended')

      expect(updated_peep).to be_a Peep
      expect(updated_peep.id).to eq peep.id
      expect(updated_peep.peep).to eq('Amended')
    end
  end
  describe '.find' do
    it 'finds a peep' do
      peep = Peep.create(peep: 'First Peep')
      found_peep = Peep.find(id: peep.id)

      expect(found_peep).to be_a Peep
      expect(found_peep.id).to eq peep.id
      expect(found_peep.peep).to eq('First Peep')
    end
  end
  let(:comment_class) { double(:comment_class) }

  describe '#comments' do
    it 'calls .where on the Comment class' do
      peep = Peep.create(peep: 'First Peep')
      expect(comment_class).to receive(:where).with(peep_id: peep.id)

      peep.comments(comment_class)
    end
  end   
end