require 'sinatra'
require 'sinatra/activerecord'

class Log < ActiveRecord::Base
end

helpers do
  def valid_key?(key)
    key.to_i == 123
  end
end

post '/logs' do
  error 401 unless valid_key?(params[:key])

  @log = Log.new(
    client: params[:client],
    temperature: params[:temperature]
  )
  @log.save
end
