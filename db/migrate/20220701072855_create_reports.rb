class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :reporting_id, null: false
      t.integer :comment_id, null: false
      t.boolean :checked, default: false, null: false
      
      t.timestamps
    end
  end
end
