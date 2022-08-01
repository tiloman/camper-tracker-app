require 'sinatra'
require 'sinatra/activerecord'
require 'geocoder'
require File.expand_path('../models/log.rb', __FILE__)
require File.expand_path('../models/trip.rb', __FILE__)

Geocoder.configure(:units => :km)
HOME_ADDRESS = [50.888151, 6.998474].freeze
MOTION_THRESHOLD = 0.5 #in km

helpers do
  def valid_key?(key)
    key.to_i == 123
  end
end

post '/logs' do
  error 401 unless valid_key?(params[:key])

  geocoder = Geocoder.search([params[:latitude], params[:longitude]])
  distance_to_last_point = Geocoder::Calculations.distance_between(
    [params[:latitude], params[:longitude]], [Log.last.latitude, Log.last.longitude]
    )
  distance_to_last_point > MOTION_THRESHOLD ? motion = true : motion = false

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
    country: geocoder.first.country,
    distance: distance_to_last_point,
    motion: motion
  )
  @log.save
end
