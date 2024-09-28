class CreateIndustries < ActiveRecord::Migration[7.2]
  def change
    create_table :industries do |t|
      t.string :name
      t.references :sector, null: false, foreign_key: true

      t.timestamps
    end
  end
end
