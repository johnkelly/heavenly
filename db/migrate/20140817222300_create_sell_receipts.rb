class CreateSellReceipts < ActiveRecord::Migration
  def change
    create_table :sell_receipts, id: :uuid do |t|
      t.uuid :product_id,               null: false
      t.uuid :person_id,                null: false
      t.string :product_title,          null: false
      t.string :product_video_url,      null: false
      t.text :product_description
      t.integer :price,                 null: false
      t.datetime :on_sale_at,           null: false
      t.datetime :expires_at,           null: false
      t.string :provider_id,            null: false
      t.string :provider,               null: false
      t.string :card_brand,             null: false
      t.string :card_funding,           null: false
      t.integer :card_last_four,        null: false
      t.integer :card_expiration_month, null: false
      t.integer :card_expiration_year,  null: false
      t.datetime :pickup_at,            null: false
      t.text :pick_up_address,          null: false
      t.decimal :pick_up_latitude,      null: false, precision: 10, scale: 6
      t.decimal :pick_up_longitude,     null: false, precision: 10, scale: 6

      t.timestamps
    end

    add_index :sell_receipts, :product_id
    add_index :sell_receipts, :person_id
    add_index :sell_receipts, :provider_id
  end
end
