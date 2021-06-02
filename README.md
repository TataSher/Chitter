# Chitter


## How to use

### To set up the project

Clone this repository and then run:

```
bundle install
```

### To run the Chitter app:

```
rackup -p 3000
rackup config.ru
```

### To run tests:

```
rspec
```

### To run linting:

```
rubocop
```
### To create development database and tables:

see 01_create_database_tables.sql in db/migration folder
```
>> psql CREATE DATABASE chitter_db_development;

>> psql \c (to connect to the database)

>> CREATE TABLE users(user_id SERIAL PRIMARY KEY, email VARCHAR (200) UNIQUE, username VARCHAR (200) UNIQUE, password VARCHAR(140));

>> CREATE TABLE peeps(id SERIAL PRIMARY KEY, peep VARCHAR (300), written_by INTEGER REFERENCES users(user_id), written_at TIMESTAMP);

```
### To create test database and tables:

see 02_create_test_database_tables.sql in db/migration folder
```
>> psql CREATE DATABASE chitter_db_test;

>> psql \c (to connect to the database)

>> CREATE TABLE users(user_id SERIAL PRIMARY KEY, email VARCHAR (200) UNIQUE, username VARCHAR (200) UNIQUE, password VARCHAR(140));

>> CREATE TABLE peeps(id SERIAL PRIMARY KEY, peep VARCHAR (300), written_by INTEGER REFERENCES users(user_id), written_at TIMESTAMP);


## User Stories

1.  As a user
    So that I can let people know what I am doing  
    I want to post a message (peep) to chitter

2.  As a user
    So that I can see what others are saying  
    I want to see all peeps in reverse chronological order

3.  As a user
    So that I can better appreciate the context of a peep
    I want to see the time at which it was made

4.  As a user
    So that I can post messages on Chitter as me
    I want to sign up for Chitter

5.  As a user
    So that only I can post messages on Chitter as me
    I want to log in to Chitter

6.  As a user
    So that I can avoid others posting messages on Chitter as me
    I want to log out of Chitter

6.  As a user
    So that I can stay constantly tapped in to the shouty box of Chitter
    I want to receive an email if I am tagged in a Peep