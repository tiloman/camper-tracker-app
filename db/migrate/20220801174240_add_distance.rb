class AddDistance < ActiveRecord::Migration[7.0]
  def change
    add_column :logs, :distance, :float
    add_column :logs, :motion, :bool
  end
end
