require 'pg'

def db_connect
  if ENV['ENVIRONMENT'] == 'test'
    @connection = PG.connect(dbname: 'chitter_db_test')
  else
    @connection = PG.connect(dbname: 'chitter_db_development')
  end
end