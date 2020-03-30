# frozen_string_literal: true

class AddTypeToFundings < ActiveRecord::Migration[6.0]
  def change
    add_column :fundings, :type, :integer
  end
end
