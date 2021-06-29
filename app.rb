# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/peep'
require 'pg'
require_relative './lib/helpers/db_connect_helper.rb'
require_relative './lib/comment'
require_relative './lib/tag'
require_relative './lib/peeptag'

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
    @user = User.find(session[:user_id])
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

  get '/peeps/:id/tags/new' do
    @peep_id = params[:id]
    erb :'tags/new'
  end

  post '/peeps/:id/tags' do
    tag = Tag.create(content: params[:tag])
    Peeptag.create(peep_id: params[:id], tag_id: tag.id)
    redirect '/peeps'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(username: params[:username], email: params[:email], password: [:password])
    session[:user_id] = user.id
    redirect '/peeps'
  end

  get '/sessions/new'do
    erb:"sessions/new"
  end
  
  post '/sessions' do
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{params[:email]}'")
    user = User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'])

    session[:user_id] = user.id
    redirect('/peeps')
  end
  
  run! if app_file == $PROGRAM_NAME
end
