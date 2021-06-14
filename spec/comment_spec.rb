require_relative 'database_helpers'
require 'comment'
require 'peep'

describe Comment do
  describe '.create' do 
    it 'creates comments on a peep' do
      peep = Peep.create(peep: 'First Peep')
      comment = Comment.create(text: 'Test Comment', peep_id: peep.id)

      persisted_data = persisted_data(table: 'comments', id: comment.id)

      expect(comment).to be_a Comment
      expect(comment.id).to eq persisted_data.first['id']
      expect(comment.text).to eq 'Test Comment'
      expect(comment.peep_id).to eq peep.id
    end
  end
  describe '.where' do 
    it 'gets comments for a peep from a database' do
      peep = Peep.create(peep: 'First Peep')
      Comment.create(text: 'First Test Comment', peep_id: peep.id)
      Comment.create(text: 'Second Test Comment', peep_id: peep.id)
      
      comments = Comment.where(peep_id: peep.id)
      comment = comments.first
      persisted_data = persisted_data(table: 'comments', id: comment.id)

      expect(comments.length).to eq 2
      expect(comment.id).to eq persisted_data.first['id']
      expect(comment.text).to eq 'First Test Comment'
      expect(comment.peep_id).to eq peep.id
    end
  end 
end