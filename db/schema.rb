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

ActiveRecord::Schema[7.2].define(version: 2024_09_28_045729) do
  create_table "deliveries", force: :cascade do |t|
    t.integer "stock_id", null: false
    t.decimal "quantity"
    t.decimal "percentage"
    t.decimal "volume"
    t.time "delivery_time"
    t.time "volume_time"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.time "delivery_time"
    t.time "volume_time"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.time "delivery_time"
    t.time "volume_time"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["industry_id"], name: "index_stocks_on_industry_id"
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

  add_foreign_key "deliveries", "stocks"
  add_foreign_key "industries", "sectors"
  add_foreign_key "industry_deliveries", "industries"
  add_foreign_key "prices", "stocks"
  add_foreign_key "sector_deliveries", "sectors"
  add_foreign_key "stocks", "industries"
  add_foreign_key "technicals", "stocks"
end
