class CreateLogs < ActiveRecord::Migration[7.0]
  def change
   create_table :logs do |t|
      t.string :client
      t.decimal :temperature, precision: 4, scale: 2

      t.timestamps
    end
  end
end
