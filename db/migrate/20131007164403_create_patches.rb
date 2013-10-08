class CreatePatches < ActiveRecord::Migration
  def change
    create_table :patches do |t|
      t.integer :user_id
      t.string  :language
      t.string  :name
      t.string  :description
      t.string  :tags
      t.text    :tests

      # Calculated values
      t.integer :implementations_count, :default => 0

      t.timestamps
    end

    add_index :patches, :user_id
    add_index :patches, :language
    add_index :patches, :name
    add_index :patches, :tags
  end
end
