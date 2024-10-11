class CreateAlerts < ActiveRecord::Migration[7.2]
  def change
    create_table :alerts do |t|
      t.references :stock, null: false, foreign_key: true
      t.references :price, null: false, foreign_key: true
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
