class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.string :password

      t.text   :token

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
