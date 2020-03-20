# frozen_string_literal: true

class ChangeRestaurantsToBusinesses < ActiveRecord::Migration[6.0]
  def change
    rename_table :restaurants, :businesses
  end
end
