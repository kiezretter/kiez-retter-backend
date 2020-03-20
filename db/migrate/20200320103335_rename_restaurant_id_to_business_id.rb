# frozen_string_literal: true

class RenameRestaurantIdToBusinessId < ActiveRecord::Migration[6.0]
  def change
    rename_column :owners, :restaurant_id, :owner_id
  end
end
