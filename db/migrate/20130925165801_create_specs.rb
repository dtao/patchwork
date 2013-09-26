class CreateSpecs < ActiveRecord::Migration
  def change
    create_table :specs do |t|
      t.integer :user_id
      t.string  :name
      t.string  :signature
      t.string  :description

      # Cached calculated values
      t.integer :implementations_count, :default => 0

      t.timestamps
    end

    add_index :specs, :name, :unique => true
  end
end
