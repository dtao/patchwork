class CreateImplementations < ActiveRecord::Migration
  def change
    create_table :implementations do |t|
      t.integer :user_id
      t.integer :spec_id
      t.string  :name
      t.text    :description
      t.text    :source

      # Cached calculated values
      t.integer :score, :default => 0

      t.timestamps
    end

    add_index :implementations, :user_id
    add_index :implementations, :spec_id
    add_index :implementations, :name
  end
end
