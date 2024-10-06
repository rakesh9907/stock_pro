class CreateWeeklies < ActiveRecord::Migration[7.2]
  def change
    create_table :weeklies do |t|
      t.references :stock, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.decimal :delivery
      t.decimal :percentage
      t.decimal :volume
      t.decimal :delivery_time
      t.decimal :volume_time
      t.decimal :total_trades

      t.timestamps
    end
  end
end
