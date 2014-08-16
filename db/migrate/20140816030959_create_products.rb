class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, id: :uuid do |t|
      t.uuid :seller_id,      null:false
      t.string :title,        null:false
      t.text :description
      t.string :video_url,    null:false
      t.integer :price,       null:false
      t.boolean :on_sale,     null:false, default: false
      t.timestamp :on_sale_at
      t.boolean :expired,     null:false, default: false
      t.timestamp :expires_at
      t.boolean :sold,        null:false, default: false
      t.timestamp :sold_at
      t.uuid :buyer_id

      t.timestamps
    end

    add_index :products, :seller_id
    add_index :products, :on_sale
    add_index :products, :expired
    add_index :products, :sold
    add_index :products, :buyer_id
  end
end
