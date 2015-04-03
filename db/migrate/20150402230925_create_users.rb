class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email, null: false
      t.text :password_digest

      t.timestamps
    end

    add_index :users, :email
  end
end
