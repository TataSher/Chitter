require 'pg'
# class Peep allows to create peep instances
class Peep

  def self.list
    connection = PG.connect(dbname: 'chitter_db_development')
    result = connection.exec( "SELECT * FROM peeps" )
    result.map { |message| message['peep']}
  end
end