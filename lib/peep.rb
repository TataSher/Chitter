require 'pg'
# class Peep allows to create peep instances
class Peep

  def self.list
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'chitter_db_test')
    else
      connection = PG.connect(dbname: 'chitter_db_development')
    end
    
    result = connection.exec( "SELECT * FROM peeps" )
    result.map { |message| message['peep']}
  end
end



