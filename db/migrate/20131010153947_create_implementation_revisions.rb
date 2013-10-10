class CreateImplementationRevisions < ActiveRecord::Migration
  def change
    create_table :implementation_revisions do |t|
      t.integer :implementation_id
      t.text    :source

      t.timestamps
    end

    add_index :implementation_revisions, :implementation_id
  end
end
