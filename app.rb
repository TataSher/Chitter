# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/peep'
require 'pg'
require_relative './lib/helpers/db_connect_helper.rb'
require_relative './lib/comment'

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
    @peep = Peep.find(id: params[:id])
    erb :'peeps/edit'
  end
  
  patch '/peeps/:id' do
    Peep.update(id: params[:id], peep: params[:peep])
    redirect('/peeps')
  end

  get '/peeps/:id/comments/new' do
    @peep_id = params[:id]
    erb :'comments/new'
  end

  post '/peeps/:id/comments' do
    Comment.create(text: params[:comment], peep_id: params[:id])
    redirect '/peeps'
  end

  run! if app_file == $PROGRAM_NAME
end
