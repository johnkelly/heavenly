class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people, id: :uuid do |t|
      t.string :auth_token,   null: false
      t.string :email,        null: false
      t.string :first_name,   null: false
      t.string :last_name,    null: false
      t.string :gender,       null: false
      t.string :locale,       null: false

      t.timestamps
    end

    add_index :people, :auth_token, unique: true
  end
end
