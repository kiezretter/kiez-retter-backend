class CreateImageReferences < ActiveRecord::Migration[6.0]
  def change
    create_table :image_references do |t|
      t.string :google_reference
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
