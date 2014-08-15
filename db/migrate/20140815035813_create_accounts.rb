class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :type,                   null: false
      t.uuid :person_id,                null: false
      t.string :provider_id,            null: false
      t.string :provider,               null: false
      t.string :card_brand,             null: false
      t.string :card_funding,           null: false
      t.integer :card_last_four,        null: false
      t.integer :card_expiration_month, null: false
      t.integer :card_expiration_year,  null: false

      t.timestamps
    end

    add_index :accounts, :type
    add_index :accounts, :person_id
    add_index :accounts, :provider_id
  end
end
