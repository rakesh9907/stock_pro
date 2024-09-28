class CreateTechnicals < ActiveRecord::Migration[7.2]
  def change
    create_table :technicals do |t|
      t.references :stock, null: false, foreign_key: true
      t.decimal :rsi
      t.decimal :rs
      t.date :date

      t.timestamps
    end
  end
end
