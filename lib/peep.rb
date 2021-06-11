require 'pg'
require 'database_connection'
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
end



