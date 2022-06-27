class CreateCoordinates < ActiveRecord::Migration[6.1]
  def change
    create_table :coordinates do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.integer :dress_code, null: false
      t.integer :season, null: false
      t.integer :temperature, null: false
      t.integer :outer_id
      t.integer :tops_id
      t.integer :bottoms_id
      t.integer :shoes_id
      t.integer :other1_id
      t.integer :other2_id

      t.timestamps
    end
  end
end
