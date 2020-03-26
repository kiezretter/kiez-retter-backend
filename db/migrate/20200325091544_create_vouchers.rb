# frozen_string_literal: true

class CreateVouchers < ActiveRecord::Migration[6.0]
  def change
    create_table :vouchers do |t|
      t.string :link
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
