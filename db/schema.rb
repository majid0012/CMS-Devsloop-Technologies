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

ActiveRecord::Schema.define(version: 2022_02_02_100716) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "email_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "invoice_item"
    t.integer "total_amount"
    t.integer "invoice_type"
    t.bigint "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_invoices_on_project_id"
  end

  create_table "leads", force: :cascade do |t|
    t.string "title"
    t.string "company_name"
    t.string "company_address"
    t.string "email_address"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "log_hours", force: :cascade do |t|
    t.datetime "date"
    t.string "time_spent"
    t.text "work_description"
    t.bigint "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_log_hours_on_project_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "budget"
    t.bigint "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_milestones_on_project_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "description"
    t.string "noteable_type"
    t.bigint "noteable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["noteable_type", "noteable_id"], name: "index_notes_on_noteable"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "project_type"
    t.datetime "start_date"
    t.datetime "submission_date"
    t.integer "project_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "client_id"
    t.index ["client_id"], name: "index_projects_on_client_id"
  end

  create_table "projects_resources", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "resource_id", null: false
    t.index ["project_id", "resource_id"], name: "index_projects_resources_on_project_id_and_resource_id"
    t.index ["resource_id", "project_id"], name: "index_projects_resources_on_resource_id_and_project_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name", null: false
    t.string "designation"
    t.integer "salary"
    t.string "email_address"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "projects", "clients"
end
