# frozen_string_literal: true

class CreateTrackings < ActiveRecord::Migration[6.0]
  def change
    create_table :trackings do |t|
      t.references :business, null: false, foreign_key: true
      t.string :action

      t.timestamps
    end
  end
end
