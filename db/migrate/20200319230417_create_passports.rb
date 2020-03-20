# frozen_string_literal: true

class CreatePassports < ActiveRecord::Migration[6.0]
  def change
    create_table :passports do |t|
      t.references :owner, null: false, foreign_key: true
      t.boolean :verified

      t.timestamps
    end
  end
end
