class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.integer :user_id
      t.string  :name
      t.string  :language
      t.text    :description
      t.text    :tests

      # Cached calculated values
      t.integer :implementations_count, :default => 0

      t.timestamps
    end

    add_index :functions, :name, :unique => true
    add_index :functions, :language
  end
end
