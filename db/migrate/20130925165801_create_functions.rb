class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.integer :user_id
      t.string  :name
      t.string  :signature
      t.string  :description
      t.string  :test_framework
      t.text    :tests

      # Cached calculated values
      t.integer :implementations_count, :default => 0

      t.timestamps
    end

    add_index :functions, :name, :unique => true
  end
end
