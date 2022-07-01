class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :comment_id
      t.integer :coordinate_id
      t.integer :user_id
      t.text :detail
      t.integer :report_class
      t.boolean :checked, default: false, null: false
      
      t.timestamps
    end
  end
end
