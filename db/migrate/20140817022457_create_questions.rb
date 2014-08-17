class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions, id: :uuid do |t|
      t.uuid :product_id, null: false
      t.text :question,   null: false
      t.uuid :asker_id,   null: false
      t.text :answer
      t.uuid :replier_id

      t.timestamps
    end

    add_index :questions, :product_id
    add_index :questions, :asker_id
    add_index :questions, :replier_id
  end
end
