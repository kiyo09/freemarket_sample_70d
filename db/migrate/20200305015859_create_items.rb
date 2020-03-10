class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :status_id
      t.integer :fee_side_id
      t.integer :shipping_days_id
      t.integer :prefecture_id
      t.integer :price
      t.integer :saler_id, foreign_key: true
      t.integer :buyer_id, foreign_key: true
      t.integer :category_id, foreign_key: true
      t.integer :size_id
      t.integer :brand_id, foreign_key: true
      t.timestamps
    end
    add_index :items,  :name
  end
end
