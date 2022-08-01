class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.datetime :start
      t.datetime :end
      t.integer :days_in_motion
      t.float :distance
      t.timestamps
    end
  end
end
