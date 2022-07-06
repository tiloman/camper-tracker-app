ActiveRecord::Schema[7.0].define(version: 2022_07_06_063340) do
  create_table "logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "client"
    t.decimal "temperature", precision: 4, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
