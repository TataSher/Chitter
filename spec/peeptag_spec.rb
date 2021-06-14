require_relative 'database_helpers'
require 'peep'
require 'peeptag'
require 'tag'


describe Peeptag do
  describe '.create' do
    it 'adds peep and tag ids to a separate table' do
      peep = Peep.create(peep:'First Tag')
      tag = Tag.create(content: 'Fun')
      peeptag = Peeptag.create(peep_id: peep.id, tag_id: tag.id)

      persisted_data = persisted_data(table: 'peeptags', id: peeptag.id)

      expect(peeptag).to be_a Peeptag
      expect(peeptag.id).to eq persisted_data.first['id']
      expect(peeptag.peep_id).to eq persisted_data.first['peep_id']
      expect(peeptag.tag_id).to eq persisted_data.first['tag_id']
    end
  end
end