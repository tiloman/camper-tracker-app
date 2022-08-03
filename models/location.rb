class Location < ActiveRecord::Base
  extend Geocoder::Model::ActiveRecord
  Geocoder.configure(:units => :km)

  geocoded_by :address
  after_validation :geocode
  scope :created_at_day, -> (day) { where(created_at: day.beginning_of_day..day.end_of_day) }

  #after_save :update_trip

  def self.location_present?
    #TODO: Find location in db with geocoder radius
    #Location.find
    #Geocoder::Calculations.distance_between([latitude, longitude], ENV['HOME_ADDRESS']) < ENV['MOTION_THRESHOLD'].to_f
  end

  def self.create_from_log(log)
    location = Location.create(
      latitude: log.latitude,
      longitude: log.longitude,
      name: log.address,
      address: log.address
    )
    location.save
  end

  def update_trip
    if Log.location_changed_today? && Log.was_home_yesterday?
      #create new trip
    elsif !Log.was_home_yesterday?
      #find existing trip and update distance accordingly
    end
  end

  def self.changed_today?
    Log.created_at_day(Time.now).in_motion.any?
  end

  def self.was_home_yesterday?
    location = Location.created_at_day(Time.now - 1.day).first
    location.is_at_home? if location.present?
  end

  def is_at_home?
    Geocoder::Calculations.distance_between([latitude, longitude], ENV['HOME_ADDRESS']) < ENV['MOTION_THRESHOLD'].to_f
  end
end
