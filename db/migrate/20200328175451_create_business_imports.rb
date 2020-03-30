# frozen_string_literal: true

class CreateBusinessImports < ActiveRecord::Migration[6.0]
  def change
    create_table :business_imports do |t|
      t.text :content
      t.datetime :imported_at
      t.integer :num_imported
      t.timestamps
    end
  end
end
