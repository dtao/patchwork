class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      # Calculated values
      t.integer :score,                 :default => 0
      t.integer :patches_count,         :default => 0
      t.integer :implementations_count, :default => 0

      t.timestamps
    end

    add_index :users, :email
  end
end
