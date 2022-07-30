class AddGeocoder < ActiveRecord::Migration[7.0]
  def change
    add_column :logs, :connected_wifi, :string
    add_column :logs, :address, :string
    add_column :logs, :country, :string
  end
end
