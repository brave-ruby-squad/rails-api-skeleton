class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string     :key,        null: false
      t.string     :key_type,   null: false, default: 'auth'
      t.datetime   :expired_at, null: false

      t.references :user, index: true, foreign_key: true

      t.timestamps
    end

    add_index :tokens, :key,        unique: true
    add_index :tokens, :expired_at, unique: true
  end
end
