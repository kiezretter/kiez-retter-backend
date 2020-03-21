# frozen_string_literal: true

class AddInfoToBusinesses < ActiveRecord::Migration[6.0]
  def change
    add_column :businesses, :phone_number, :string
    add_column :businesses, :street_address, :string
    add_column :businesses, :postcode, :string
    add_column :businesses, :city, :string
    add_column :businesses, :personal_message, :text
    add_column :businesses, :personal_thank_you, :text
  end
end
