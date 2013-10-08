class CreateImplementations < ActiveRecord::Migration
  def change
    create_table :implementations do |t|
      t.integer :user_id
      t.integer :patch_id
      t.text    :source

      # Calculated values
      t.integer :score, :default => 0

      t.timestamps
    end

    add_index :implementations, :user_id
    add_index :implementations, :patch_id
  end
end
