class Location < ActiveRecord::Base
  def self.location_present?
    #TODO: Find location in db with geocoder radius
  end

  def self.create_from_log(log)
    location = Location.create(
      latitude: log.latitude,
      longitude: log.longitude,
      name: log.address
    )
    location.save
  end
end
