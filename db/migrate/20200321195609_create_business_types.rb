# frozen_string_literal: true

class CreateBusinessTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :business_types do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
