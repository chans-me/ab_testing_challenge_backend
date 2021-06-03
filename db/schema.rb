# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_03_061853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_variants", force: :cascade do |t|
    t.bigint "article_id"
    t.string "variant_name"
    t.index ["article_id", "variant_name"], name: "article_variants_unique_composite_keys", unique: true
    t.index ["article_id"], name: "index_article_variants_on_article_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
  end

  create_table "visitor_article_mappings", force: :cascade do |t|
    t.bigint "visitor_id"
    t.bigint "article_id"
    t.bigint "article_variant_id"
    t.boolean "signup_event", default: false
    t.index ["article_id"], name: "index_visitor_article_mappings_on_article_id"
    t.index ["article_variant_id"], name: "index_visitor_article_mappings_on_article_variant_id"
    t.index ["visitor_id", "article_id"], name: "visitor_article_mappings_unique_composite_keys", unique: true
    t.index ["visitor_id"], name: "index_visitor_article_mappings_on_visitor_id"
  end

  create_table "visitor_article_page_views", force: :cascade do |t|
    t.bigint "visitor_article_mapping_id"
    t.index ["visitor_article_mapping_id"], name: "index_visitor_article_page_views_on_visitor_article_mapping_id"
  end

  create_table "visitors", force: :cascade do |t|
    t.string "visitor_address"
    t.index ["visitor_address"], name: "index_visitors_on_visitor_address", unique: true
  end

  add_foreign_key "article_variants", "articles"
  add_foreign_key "visitor_article_mappings", "article_variants"
  add_foreign_key "visitor_article_mappings", "articles"
  add_foreign_key "visitor_article_mappings", "visitors"
  add_foreign_key "visitor_article_page_views", "visitor_article_mappings"
end
