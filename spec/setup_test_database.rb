require 'pg'

def setup_test_database 

  p "Setting up test database...Re-creating tables..."

  connection = PG.connect(dbname: 'chitter_db_test')
  connection.exec("DROP TABLE users, peeps;")
  connection.exec("CREATE TABLE users(user_id SERIAL PRIMARY KEY, email VARCHAR (200) UNIQUE, username VARCHAR (200) UNIQUE, password VARCHAR(140));")
  connection.exec("CREATE TABLE peeps(id SERIAL PRIMARY KEY, peep VARCHAR (300), written_by INTEGER REFERENCES users(user_id), written_at TIMESTAMP);")
end

def add_users
  p "Adding users..."
  connection = PG.connect(dbname: 'chitter_db_test')
  connection.exec("INSERT INTO users (email, username, password) VALUES ('1@1.com' , 'User1', 111);")
end

def add_peeps
  p "Adding peeps..."
  connection = PG.connect(dbname: 'chitter_db_test')
  connection.exec("INSERT INTO peeps (peep, written_by) VALUES ('First Peep' , '1');")
  connection.exec("INSERT INTO peeps (peep, written_by) VALUES ('Second Peep' , '1');")
  connection.exec("INSERT INTO peeps (peep, written_by) VALUES ('Third Peep' , '1');")
end