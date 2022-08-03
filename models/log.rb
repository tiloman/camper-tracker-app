class Log < ActiveRecord::Base
  extend Geocoder::Model::ActiveRecord

  default_scope ->{ order(created_at: :asc) }
  scope :created_at_day, -> (day) { where(created_at: day.beginning_of_day..day.end_of_day) }
  scope :in_motion, -> { where(motion: true) }

  after_save :update_trip
  after_save :set_location

  def update_trip
    if Log.location_changed_today? && Log.was_home_yesterday?
      #create new trip
    elsif !Log.was_home_yesterday?
      #find existing trip and update distance accordingly
    end
    #do nothing
  end

  def self.location_changed_today?
    #could be a scope?
    Log.created_at_day(Time.now).in_motion.any?
  end

  def self.was_home_yesterday?
    #could be a scope?
    logs = Log.created_at_day(Time.now - 1.day).in_motion
    if logs.any?
      return logs.last.is_at_home?
    end
  end

  def is_at_home?
    Geocoder::Calculations.distance_between([latitude, longitude], ENV['HOME_ADDRESS']) < ENV['MOTION_THRESHOLD'].to_f
  end

  def set_location
    if self == Log.created_at_day(Time.now).first
      Location.create_from_log(self)
    end
  end
end
