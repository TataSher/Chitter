require 'pg'
require_relative './helpers/db_connect_helper.rb'
# class Peep allows to create peep instances
class Peep

  def self.list
    db_connect 
    result = @connection.exec( "SELECT * FROM peeps" )
    result.map { |message| message['peep']}
  end

  def self.create(peep:)
    db_connect
    result = @connection.exec("INSERT INTO peeps (peep) VALUES ('#{peep}');")
  end
end



