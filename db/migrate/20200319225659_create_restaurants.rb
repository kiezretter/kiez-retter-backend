# frozen_string_literal: true

class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.integer :gmap_id
      t.string :name
      t.float :lat
      t.float :lng
      t.boolean :verified

      t.timestamps
    end
  end
end
