require_relative 'database_helpers'
require 'peep'
require 'tag'

describe Tag do
  describe '.create' do
    it 'creates a tag on peep' do
      tag = Tag.create(content: 'Arts')

      persisted_data = persisted_data(table: 'tags', id: tag.id)

      expect(tag).to be_a Tag
      expect(tag.id).to eq persisted_data.first['id']
      expect(tag.content).to eq persisted_data.first['content']
    end
      it 'uses the existing tag if the tag content matches' do
        tag1 = Tag.create(content: 'Fun')
        tag2 = Tag.create(content: 'Fun')

        expect(tag1.id).to eq tag2['id']
      end
    end
  describe '.where' do
    it 'returns tags linked to a peep id' do
      peep_1 = Peep.create(peep:'First Tag')
      tag_1 = Tag.create(content: 'One')
      tag_2 = Tag.create(content: 'Two')
      Peeptag.create(peep_id: peep_1.id, tag_id: tag_1.id)
      Peeptag.create(peep_id: peep_1.id, tag_id: tag_2.id)

      tags = Tag.where(peep_id: peep_1.id)
      tag = tags.first

      expect(tags.length).to eq 2
      expect(tag).to be_a Tag
      expect(tag.id).to eq tag_1.id
      expect(tag.content).to eq tag_1.content
    end
  end
end
         