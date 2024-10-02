class CreateSubBookmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :sub_bookmarks do |t|
      t.references :stock, null: false, foreign_key: true
      t.references :bookmark, null: false, foreign_key: true
      t.decimal :added_price
      t.datetime :added_date

      t.timestamps
    end
  end
end
