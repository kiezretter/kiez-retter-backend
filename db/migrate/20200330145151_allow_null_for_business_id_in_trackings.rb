# frozen_string_literal: true

class AllowNullForBusinessIdInTrackings < ActiveRecord::Migration[6.0]
  def change
    change_column_null :trackings, :business_id, true
  end
end
