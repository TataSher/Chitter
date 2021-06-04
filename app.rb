# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/peep'
require 'pg'

# Chitter controller
class Chitter < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Chitter'
  end

  get '/peeps' do
    @peeps = Peep.list
    erb :'peeps/index'
  end

  get '/peeps/new' do
    erb :'peeps/new'
  end

  post '/peeps' do
    peep = params['peep']
    connection = PG.connect(dbname: 'chitter_db_development')
    connection.exec("INSERT INTO peeps (peep) VALUES ('#{peep}');")
    redirect '/peeps'
  end


  run! if app_file == $PROGRAM_NAME
end
