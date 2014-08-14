class CreateAuthProviders < ActiveRecord::Migration
  def change
    create_table :auth_providers, id: :uuid do |t|
      t.string :type,               null: false
      t.uuid :person_id,            null: false
      t.string :provider_person_id, null: false
      t.string :token,              null: false
      t.datetime :expiration,       null: false
      t.string :link,               null: false
      t.boolean :verified,          null: false, default: false

      t.timestamps
    end

    add_index :auth_providers, :person_id
    add_index :auth_providers, :provider_person_id
    add_index :auth_providers, :type
    add_index :auth_providers, :token
  end
end
