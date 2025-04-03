class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.text :content, null: false
      t.integer :token_count, null: false, default: 0
      t.string :message_type, null: false
      t.integer :position, null: false
      t.boolean :active, null: false, default: true

      t.timestamps

      t.index :message_type
      t.index :position
      t.index :active
    end
  end
end
