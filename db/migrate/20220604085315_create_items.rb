class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :item_name, null: false
      t.string :brand_name, null: false
      t.integer :category, null: false
      t.integer :category_detail, null: false
      t.string :size, null: false
      t.string :color, null: false
      t.integer :user_id, null: false
      t.integer :price, null: false
      
      t.timestamps
    end
  end
end
