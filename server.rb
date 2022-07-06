require 'sinatra'
require 'sinatra/activerecord'

class Log < ActiveRecord::Base
end

class App < Sinatra::Application
end

get '/' do
  @logs = Log.all
  @logs.to_json
end

post "/logs" do
  @log = Log.new(params)
  @log.save
end
