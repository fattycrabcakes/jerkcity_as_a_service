class CreateCharacters < ActiveRecord::Migration
  def change
	create_table "characters", force: :cascade do |t|
    	t.string "name", limit: 128
  	end

  	create_table "comics", force: :cascade do |t|
    	t.text "title"
  	end

  	create_table "dialogues", force: :cascade do |t|
    	t.integer "comic_id"
    	t.integer "speaker_id"
    	t.text    "speech"
  	end

  	create_table "widgets", force: :cascade do |t|
    	t.string   "name"
    	t.text     "description"
    	t.integer  "stock"
    	t.datetime "created_at"
    	t.datetime "updated_at"
  	end
  end
end
