# frozen_string_literal: true

class CreateDonations < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.references :business, null: false, foreign_key: true
      t.integer :amount_cents

      t.timestamps
    end
  end
end
