# frozen_string_literal: true

class CreateDeadLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :dead_links do |t|
      t.references :funding, null: false, foreign_key: true
      t.string :link

      t.timestamps
    end
  end
end
