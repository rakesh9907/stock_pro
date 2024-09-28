class CreatePrices < ActiveRecord::Migration[7.2]
  def change
    create_table :prices do |t|
      t.references :stock, null: false, foreign_key: true
      t.decimal :open
      t.decimal :close
      t.decimal :high
      t.decimal :low
      t.date :date
      t.decimal :fifty_two_week_high
      t.decimal :fifty_two_week_low
      t.decimal :vwap

      t.timestamps
    end
    add_index :prices, [:stock_id, :date], unique: true
  end
end
