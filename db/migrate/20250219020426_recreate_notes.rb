class RecreateNotes < ActiveRecord::Migration[8.0]
  def up
    drop_table :notes, if_exists: true

    create_table :notes, id: false do |t|
      t.string :id, primary_key: true, null: false
      t.string :title, null: false
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :notes, if_exists: true
  end
end
