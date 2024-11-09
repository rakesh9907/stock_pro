# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_08_130135) do
  create_table "alert_items", force: :cascade do |t|
    t.integer "stock_id", null: false
    t.decimal "price"
    t.date "date"
    t.integer "alert_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_alert_items_on_alert_id"
    t.index ["stock_id"], name: "index_alert_items_on_stock_id"
  end

  create_table "alerts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookmarks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.integer "stock_id", null: false
    t.decimal "quantity"
    t.decimal "percentage"
    t.decimal "volume"
    t.decimal "delivery_time"
    t.decimal "volume_time"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "trades"
    t.index ["stock_id", "date"], name: "index_deliveries_on_stock_id_and_date", unique: true
    t.index ["stock_id"], name: "index_deliveries_on_stock_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.integer "sector_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sector_id"], name: "index_industries_on_sector_id"
  end

  create_table "industry_deliveries", force: :cascade do |t|
    t.integer "industry_id", null: false
    t.decimal "quantity"
    t.decimal "percentage"
    t.decimal "volume"
    t.decimal "delivery_time"
    t.decimal "volume_time"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "trades"
    t.index ["industry_id", "date"], name: "index_industry_deliveries_on_industry_id_and_date", unique: true
    t.index ["industry_id"], name: "index_industry_deliveries_on_industry_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "stock_id", null: false
    t.decimal "open"
    t.decimal "close"
    t.decimal "high"
    t.decimal "low"
    t.date "date"
    t.decimal "fifty_two_week_high"
    t.decimal "fifty_two_week_low"
    t.decimal "vwap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id", "date"], name: "index_prices_on_stock_id_and_date", unique: true
    t.index ["stock_id"], name: "index_prices_on_stock_id"
  end

  create_table "sector_deliveries", force: :cascade do |t|
    t.integer "sector_id", null: false
    t.decimal "quantity"
    t.decimal "percentage"
    t.decimal "volume"
    t.decimal "delivery_time"
    t.decimal "volume_time"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "trades"
    t.index ["sector_id", "date"], name: "index_sector_deliveries_on_sector_id_and_date", unique: true
    t.index ["sector_id"], name: "index_sector_deliveries_on_sector_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string "name"
    t.integer "industry_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "symbol"
    t.string "category"
    t.index ["industry_id"], name: "index_stocks_on_industry_id"
  end

  create_table "sub_bookmarks", force: :cascade do |t|
    t.integer "stock_id", null: false
    t.integer "bookmark_id", null: false
    t.decimal "added_price"
    t.datetime "added_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bookmark_id"], name: "index_sub_bookmarks_on_bookmark_id"
    t.index ["stock_id"], name: "index_sub_bookmarks_on_stock_id"
  end

  create_table "technicals", force: :cascade do |t|
    t.integer "stock_id", null: false
    t.decimal "rsi"
    t.decimal "rs"
    t.date "date"
    t.decimal "ema_20"
    t.decimal "ema_50"
    t.decimal "ema_200"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_technicals_on_stock_id"
  end

  create_table "weekly_deliveries", force: :cascade do |t|
    t.integer "stock_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.decimal "delivery"
    t.decimal "percentage"
    t.decimal "volume"
    t.decimal "delivery_time"
    t.decimal "volume_time"
    t.decimal "total_trades"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "quantity"
    t.index ["stock_id"], name: "index_weekly_deliveries_on_stock_id"
  end

  add_foreign_key "alert_items", "alerts"
  add_foreign_key "alert_items", "stocks"
  add_foreign_key "deliveries", "stocks"
  add_foreign_key "industries", "sectors"
  add_foreign_key "industry_deliveries", "industries"
  add_foreign_key "prices", "stocks"
  add_foreign_key "sector_deliveries", "sectors"
  add_foreign_key "stocks", "industries"
  add_foreign_key "sub_bookmarks", "bookmarks"
  add_foreign_key "sub_bookmarks", "stocks"
  add_foreign_key "technicals", "stocks"
  add_foreign_key "weekly_deliveries", "stocks"
end
