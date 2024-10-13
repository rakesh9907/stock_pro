class CreateAlertItems < ActiveRecord::Migration[7.2]
  def change
    create_table :alert_items do |t|
      t.references :stock, null: false, foreign_key: true
      t.decimal :price
      t.date :date
      t.references :alert, null: false, foreign_key: true

      t.timestamps
    end
  end
end
