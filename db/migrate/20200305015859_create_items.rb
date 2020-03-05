class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :status, null: false
      t.string :fee_side, null: false
      t.string :prefectures, null: false
      t.string :shipping_days, null: false
      t.integer :price, null: false
      t.integer :saler_id, null: false, foreign_key: true
      t.integer :buyer_id, foreign_key: true
      t.integer :categ_idory, null: false, foreign_key: true
      t.string :size
      t.integer :brand_id, foreign_key: true
      t.timestamps
    end
    add_index :items,  :name
  end
end
