require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv/load'
require 'geocoder'
require File.expand_path('../models/log.rb', __FILE__)
require File.expand_path('../models/trip.rb', __FILE__)
require File.expand_path('../models/location.rb', __FILE__)

Geocoder.configure(:units => :km)

helpers do
  def valid_key?(key)
    key.to_s == ENV['AUTH_TOKEN'].to_s
  end
end

post '/logs' do
  error 401 unless valid_key?(params[:key])

  geocoder = Geocoder.search([params[:latitude], params[:longitude]])
  #TODO: unless lat and long == 0
  distance_to_last_point = Geocoder::Calculations.distance_between(
    [params[:latitude], params[:longitude]], [Log.last.latitude, Log.last.longitude]
    )
  distance_to_last_point > ENV['MOTION_THRESHOLD'].to_f ? motion = true : motion = false
  corrected_speed = params[:speed].to_f > ENV['SPEED_THRESHOLD'].to_f ? params[:speed] : 0
  corrected_distance = motion ? distance_to_last_point : 0,

  @log = Log.new(
    client: params[:client],
    temperature: params[:temperature],
    humidity: params[:humidity],
    latitude: params[:latitude],
    longitude: params[:longitude],
    satellites: params[:satellites],
    speed: params[:speed],
    corrected_speed: corrected_speed,
    altitude: params[:altitude],
    connected_wifi: params[:wifi],
    address: geocoder.first.address,
    country: geocoder.first.country,
    distance: distance_to_last_point,
    corrected_distance: corrected_distance,
    motion: motion
  )
  @log.save
end
