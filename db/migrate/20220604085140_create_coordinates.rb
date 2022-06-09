class CreateCoordinates < ActiveRecord::Migration[6.1]
  def change
    create_table :coordinates do |t|
      t.integer :user_id, null: false
      t.integer :coordinate_item_id
      t.string :title, null: false
      t.text :body, null: false
      t.integer :dress_code, null: false
      t.integer :season, null: false
      t.integer :temperature, null: false
      t.integer :total_price

      t.timestamps
    end
  end
end
