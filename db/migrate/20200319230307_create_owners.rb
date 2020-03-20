# frozen_string_literal: true

class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.string :email
      t.string :paypal_handle
      t.text :personal_message
      t.string :personal_image_link

      t.timestamps
    end
  end
end
