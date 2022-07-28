class AddHumidity < ActiveRecord::Migration[7.0]
  def change
    add_column :logs, :humindity, :decimal
  end
end
