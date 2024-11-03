class AddCategoryToStocks < ActiveRecord::Migration[7.2]
  def change
    add_column :stocks, :category, :string
  end
end
