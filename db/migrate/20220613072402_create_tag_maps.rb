class CreateTagMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_maps do |t|
      
      #referencesとforeign_keyの方法でアソシエーション用カラム作成してみました
      t.references :coordinate, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
