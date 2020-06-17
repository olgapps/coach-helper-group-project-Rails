class MainMigration < ActiveRecord::Migration[5.2]
  def change
    create_table "active_storage_attachments", force: :cascade do |t|
      t.string "name", null: false
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.bigint "blob_id", null: false
      t.datetime "created_at", null: false
      t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
      t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
    end
  
    create_table "active_storage_blobs", force: :cascade do |t|
      t.string "key", null: false
      t.string "filename", null: false
      t.string "content_type"
      t.text "metadata"
      t.bigint "byte_size", null: false
      t.string "checksum", null: false
      t.datetime "created_at", null: false
      t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
    end
  
    create_table "events", force: :cascade do |t|
      t.string "opponent"
      t.datetime "event_date"
      t.integer "event_type"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "injuries", force: :cascade do |t|
      t.bigint "player_id"
      t.text "description", default: "", null: false
      t.datetime "final_date", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["player_id"], name: "index_injuries_on_player_id"
    end
  
    create_table "players", force: :cascade do |t|
      t.string "name", null: false
      t.string "surname", null: false
      t.integer "number", null: false
      t.datetime "birth_date", null: false
      t.integer "red_cards", default: 0, null: false
      t.integer "yellow_cards", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "user_id"
      t.integer "trained_in"
      t.index ["user_id"], name: "index_players_on_user_id"
    end
  
    create_table "users", force: :cascade do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "team", default: "", null: false
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    end
  
    add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
    add_foreign_key "injuries", "players"
    add_foreign_key "players", "users"
  end
end