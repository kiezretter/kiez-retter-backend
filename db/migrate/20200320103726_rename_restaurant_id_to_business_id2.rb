# frozen_string_literal: true

class RenameRestaurantIdToBusinessId2 < ActiveRecord::Migration[6.0]
  def change
    rename_column :owners, :owner_id, :business_id
  end
end
