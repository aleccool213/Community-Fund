# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150304210040) do

  create_table "avatars", force: true do |t|
    t.integer  "user_id"
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communities", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.boolean  "active",      default: true
    t.string   "glyph"
    t.string   "icon"
  end

  create_table "communities_projects", id: false, force: true do |t|
    t.integer "community_id"
    t.integer "project_id"
  end

  add_index "communities_projects", ["community_id"], name: "index_communities_projects_on_community_id"
  add_index "communities_projects", ["project_id"], name: "index_communities_projects_on_project_id"

  create_table "feedbacks", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.boolean  "submitted",   default: false
    t.integer  "rating",      default: 0
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "dismissed",   default: false
  end

  add_index "feedbacks", ["project_id"], name: "index_feedbacks_on_project_id"
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id"

  create_table "funds", force: true do |t|
    t.decimal  "amount",     default: 0.0
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "reward_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "funds", ["project_id"], name: "index_funds_on_project_id"
  add_index "funds", ["user_id"], name: "index_funds_on_user_id"

  create_table "milestones", force: true do |t|
    t.integer  "project_id"
    t.decimal  "percentage",     default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "fund_id"
    t.integer  "users_id"
    t.string   "milestone_type"
  end

  add_index "milestones", ["users_id"], name: "index_milestones_on_users_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "community_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rewards_id"
    t.datetime "completion_date"
    t.decimal  "target_amount"
    t.boolean  "open"
    t.decimal  "current_funding"
    t.string   "location"
    t.boolean  "funding_successful", default: false
    t.string   "banner"
  end

  add_index "projects", ["rewards_id"], name: "index_projects_on_rewards_id"

  create_table "reports", force: true do |t|
    t.string   "reported_obj_type", null: false
    t.integer  "reported_obj_id",   null: false
    t.integer  "user_id",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rewards", force: true do |t|
    t.decimal  "reward_level"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "funds_id"
  end

  add_index "rewards", ["funds_id"], name: "index_rewards_on_funds_id"

  create_table "seed_migration_data_migrations", force: true do |t|
    t.string   "version"
    t.integer  "runtime"
    t.datetime "migrated_on"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "community_id"
    t.integer  "project_id"
    t.string   "hometown"
    t.string   "homestate"
    t.boolean  "admin",                  default: false, null: false
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
