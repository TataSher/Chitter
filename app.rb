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


  run! if app_file == $PROGRAM_NAME
end
