class AddUuidColumnToNotes < ActiveRecord::Migration[8.0]
  def change
    add_column :notes, :uuid, :string, null: false
  end
end
