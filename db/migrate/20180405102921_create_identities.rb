class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.string     :uid,      null: false
      t.string     :provider, null: false
      t.datetime   :verified_at

      t.references :user, index: true, foreign_key: true

      t.timestamps
    end

    add_index :identities, :uid
  end
end
