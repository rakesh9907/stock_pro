class CreateSectorDeliveries < ActiveRecord::Migration[7.2]
  def change
    create_table :sector_deliveries do |t|
      t.references :sector, null: false, foreign_key: true
      t.decimal :quantity
      t.decimal :percentage
      t.decimal :volume
      t.decimal :delivery_time
      t.decimal :volume_time
      t.date :date

      t.timestamps
    end
    add_index :sector_deliveries, [:sector_id, :date], unique: true
  end
end
