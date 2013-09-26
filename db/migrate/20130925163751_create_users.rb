class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :real_name
      t.string :email
      t.string :password_digest

      # Cached calculated values
      t.integer :score, :default => 0

      t.timestamps
    end

    add_index :users, :user_name, :unique => true
    add_index :users, :email
  end
end
