class CreateCoordinateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :coordinate_items do |t|
      t.integer :coordinate_id, null: false
      t.integer :outer_item_id
      t.integer :tops_item_id
      t.integer :bottoms_item_id
      t.integer :shoes_item_id
      t.integer :other_item1_id
      t.integer :other_item2_id

      t.timestamps
    end
  end
end
