class AddKitTokenToStocks < ActiveRecord::Migration[7.2]
  def change
    add_column :stocks, :kit_token, :string
  end
end
