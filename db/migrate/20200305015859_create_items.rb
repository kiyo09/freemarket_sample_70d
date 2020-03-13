class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :status_id, null: false
      t.integer :fee_side_id, null: false
      t.integer :shipping_days_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :price, null: false
      t.integer :buyer_id, foreign_key: true
      t.integer :user_id, null: false, foreign_key: true
      t.integer :category_id, null: false
      t.integer :size_id
      t.integer :brand_id, foreign_key: true
      t.timestamps
    end
    add_index :items,  :name
  end
end
