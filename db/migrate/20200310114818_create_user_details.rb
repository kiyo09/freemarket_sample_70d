class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.string :name,             null:false
      t.string :name_kana,        null:false
      t.integer :birthday,        null:false
      t.string :desination_name,  null:false
      t.string :desination_kana,  null:false
      t.integer :post_code,       null:false
      t.string :prefectures,      null:false
      t.string :mayor,            null:false
      t.string :address,          null:false
      t.text :building
      t.integer :phone_no
      t.references :user,          foreign_key: true

      t.timestamps
    end
  end
end
