class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :subject_id
      t.string  :subject_type
      t.text    :content

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :subject_id
    add_index :comments, :subject_type
  end
end
