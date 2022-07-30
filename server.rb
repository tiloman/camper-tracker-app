require 'sinatra'
require 'sinatra/activerecord'
require 'geocoder'

class Log < ActiveRecord::Base
  extend Geocoder::Model::ActiveRecord
end

helpers do
  def valid_key?(key)
    key.to_i == 123
  end
end

post '/logs' do
  error 401 unless valid_key?(params[:key])

  geocoder = Geocoder.search([params[:latitude], params[:longitude]])
  @log = Log.new(
    client: params[:client],
    temperature: params[:temperature],
    humidity: params[:humidity],
    latitude: params[:latitude],
    longitude: params[:longitude],
    satellites: params[:satellites],
    speed: params[:speed],
    altitude: params[:altitude],
    connected_wifi: params[:wifi],
    address: geocoder.first.address,
    country: geocoder.first.country
  )
  @log.save
end
