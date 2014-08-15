class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses, id: :uuid do |t|
      t.uuid :person_id,      null: false
      t.string :street1,      null: false
      t.string :street2
      t.string :city,         null: false
      t.string :region,       null: false
      t.string :postal_code,  null: false
      t.string :country,      null: false
      t.decimal :latitude,    null: false, precision: 10, scale: 6
      t.decimal :longitude,   null: false, precision: 10, scale: 6

      t.timestamps
    end

    add_index :addresses, :person_id
    add_index :addresses, :latitude
    add_index :addresses, :longitude
  end
end
