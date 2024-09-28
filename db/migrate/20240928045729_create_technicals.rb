class CreateTechnicals < ActiveRecord::Migration[7.2]
  def change
    create_table :technicals do |t|
      t.references :stock, null: false, foreign_key: true
      t.decimal :rsi
      t.decimal :rs
      t.date :date
      t.decimal :ema_20
      t.decimal :ema_50
      t.decimal :ema_200

      t.timestamps
    end
  end
end
