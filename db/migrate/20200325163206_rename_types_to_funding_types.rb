# frozen_string_literal: true

class RenameTypesToFundingTypes < ActiveRecord::Migration[6.0]
  def change
    rename_column :fundings, :type, :funding_type
  end
end
