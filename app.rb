# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/peep'
require 'pg'
require_relative './lib/helpers/db_connect_helper.rb'

# Chitter controller
class Chitter < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override

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
    new_peep = params['peep']
    Peep.create(peep: new_peep)
    redirect '/peeps'
  end

  delete '/peeps/:id' do
     Peep.delete(id: params['id'])
     redirect '/peeps'
  end
  
  get '/peeps/:id/edit' do
    @peep_id = params['id']
    erb :'peeps/edit'
  end
  
  patch '/peeps/:id' do
    connection = PG.connect(dbname: 'chitter_db_test')
    connection.exec("UPDATE peeps SET peep = '#{params[:peep]}' WHERE id = '#{params[:id]}'")

    redirect('/peeps')
  end

  run! if app_file == $PROGRAM_NAME
end
