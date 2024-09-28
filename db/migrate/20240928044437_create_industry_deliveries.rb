class CreateIndustryDeliveries < ActiveRecord::Migration[7.2]
  def change
    create_table :industry_deliveries do |t|
      t.references :industry, null: false, foreign_key: true
      t.decimal :quantity
      t.decimal :percentage
      t.decimal :volume
      t.time :delivery_time
      t.time :volume_time
      t.date :date

      t.timestamps
    end
    add_index :industry_deliveries, [:industry_id, :date], unique: true
  end
end
