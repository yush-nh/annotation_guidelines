class RenameAnnotationGuidelinesToNotes < ActiveRecord::Migration[8.0]
  def change
    rename_table :annotation_guidelines, :notes
  end
end
