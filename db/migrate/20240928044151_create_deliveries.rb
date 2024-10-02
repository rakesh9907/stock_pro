class CreateDeliveries < ActiveRecord::Migration[7.2]
  def change
    create_table :deliveries do |t|
      t.references :stock, null: false, foreign_key: true
      t.decimal :quantity
      t.decimal :percentage
      t.decimal :volume
      t.decimal :delivery_time
      t.decimal :volume_time
      t.date :date

      t.timestamps
    end
    add_index :deliveries, [:stock_id, :date], unique: true
  end
end
