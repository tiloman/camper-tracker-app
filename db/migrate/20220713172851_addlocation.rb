class Addlocation < ActiveRecord::Migration[7.0]
  def change
    add_column :logs, :latitude, :string
    add_column :logs, :longitude, :string
  end
end
