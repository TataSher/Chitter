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
  end
end
         