class CreateCoordinateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :coordinate_items do |t|
      t.integer :coordinate_id
      t.integer :item_id

      t.timestamps
    end
  end
end
