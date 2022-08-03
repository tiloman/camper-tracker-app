class Log < ActiveRecord::Base
  extend Geocoder::Model::ActiveRecord
  Geocoder.configure(:units => :km)

  default_scope ->{ order(created_at: :asc) }
  scope :created_at_day, -> (day) { where(created_at: day.beginning_of_day..day.end_of_day) }
  scope :in_motion, -> { where(motion: true) }

  after_save :set_location

  def set_location
    if self == Log.created_at_day(Time.now).first
      Location.create_from_log(self)
    end
  end
end
