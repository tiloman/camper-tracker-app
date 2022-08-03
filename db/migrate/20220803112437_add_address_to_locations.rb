class AddAddressToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :address, :string
    add_column :locations, :visits, :integer
  end
end
