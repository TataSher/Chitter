require 'pg'
require_relative './helpers/db_connect_helper.rb'
# class Peep allows to create peep instances
class Peep

  attr_reader :id, :peep

  def initialize(id:, peep:)
    @id = id
    @peep = peep
  end

  def self.list
    db_connect 
    result = @connection.exec( "SELECT * FROM peeps" )
    result.map do |peep| 
      Peep.new(id: peep['id'], peep: peep['peep'])
    end
  end

  def self.create(peep:)
    db_connect
    result = @connection.exec("INSERT INTO peeps (peep) VALUES ('#{peep}') RETURNING id, peep;")
    Peep.new(id: result[0]['id'], peep: result[0]['peep'])
  end

end



