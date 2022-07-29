class AddMoarData < ActiveRecord::Migration[7.0]
  def change
    add_column :logs, :satellites, :integer
    add_column :logs, :altitude, :decimal
    add_column :logs, :speed, :decimal
  end
end
