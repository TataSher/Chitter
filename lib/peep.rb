require 'pg'
require_relative './database_connection.rb'
# class Peep allows to create peep instances
class Peep

  attr_reader :id, :peep

  def initialize(id:, peep:)
    @id = id
    @peep = peep
  end

  def self.list 
    result = DatabaseConnection.query( "SELECT * FROM peeps" )
    result.map do |peep| 
      Peep.new(id: peep['id'], peep: peep['peep'])
    end
  end

  def self.create(peep:)
    result = DatabaseConnection.query("INSERT INTO peeps (peep) VALUES ('#{peep}') RETURNING id, peep;")
    Peep.new(id: result[0]['id'], peep: result[0]['peep'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM peeps WHERE id = #{id}")
  end

  def self.update(id:, peep:)
    result = DatabaseConnection.query("UPDATE peeps SET peep = '#{peep}' WHERE id = '#{id}' RETURNING id, peep;")
    Peep.new(id: result[0]['id'], peep: result[0]['peep'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM peeps WHERE id = '#{id}' ")
    Peep.new(id: result[0]['id'], peep: result[0]['peep'])
  end

  def comments(comment_class = Comment)
    comment_class.where(peep_id: id)
  end

  def tags(tag_class = Tag)
    tag_class.where(peep_id: id)
  end
end



