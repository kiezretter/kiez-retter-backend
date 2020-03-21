# frozen_string_literal: true

class RemoveUnusedColumnsFromOwners < ActiveRecord::Migration[6.0]
  def change
    remove_column :owners, :personal_message
    remove_column :owners, :personal_image_link
  end
end
