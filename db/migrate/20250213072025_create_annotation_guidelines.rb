class CreateAnnotationGuidelines < ActiveRecord::Migration[8.0]
  def change
    create_table :annotation_guidelines do |t|
      t.string :title, null: false
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
