# frozen_string_literal: true

class RemoveVerifiedFromPassports < ActiveRecord::Migration[6.0]
  def change
    remove_column :passports, :verified
  end
end
