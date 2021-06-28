require 'pg'
require './lib/peep'

def setup_test_database 

  connection = PG.connect(dbname: 'chitter_db_test')
  connection.exec("DROP TABLE users, peeps, comments, tags, peeptags;")
  connection.exec("CREATE TABLE users(id SERIAL PRIMARY KEY, email VARCHAR (200) UNIQUE, username VARCHAR (200) UNIQUE, password VARCHAR(140));")
  connection.exec("CREATE TABLE peeps(id SERIAL PRIMARY KEY, peep VARCHAR (300), written_by INTEGER REFERENCES users(id), written_at TIMESTAMP);")
  connection.exec("CREATE TABLE comments(id SERIAL PRIMARY KEY, text VARCHAR(300), peep_id INTEGER REFERENCES peeps (id));")
  connection.exec("CREATE TABLE tags(id SERIAL PRIMARY KEY, content VARCHAR(60));")
  connection.exec("CREATE TABLE peeptags(id SERIAL PRIMARY KEY, peep_id INTEGER REFERENCES peeps (id), tag_id INTEGER REFERENCES tags (id));")
end

def add_users

  connection = PG.connect(dbname: 'chitter_db_test')
  connection.exec("INSERT INTO users (email, username, password) VALUES ('1@1.com' , 'User1', 111);")
end

def add_peeps
  Peep.create(peep: 'First Peep')
  Peep.create(peep: 'Second Peep')
  Peep.create(peep: 'Third Peep')
end
