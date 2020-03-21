# frozen_string_literal: true

class AddBusinessTypeToBusiness < ActiveRecord::Migration[6.0]
  def change
    add_reference :businesses, :business_type, null: false, foreign_key: true
  end
end
