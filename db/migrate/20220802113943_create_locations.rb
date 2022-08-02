class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :logs, :corrected_speed, :float
    add_column :logs, :corrected_distance, :float
    create_table :locations do |t|
      t.datetime :arrived_at
      t.datetime :left_at
      t.string :name
      t.string :latitude
      t.string :longitude
      t.timestamps
    end
  end
end
