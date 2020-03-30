# frozen_string_literal: true

class AddBusinessCountToBusinessImports < ActiveRecord::Migration[6.0]
  def change
    add_column :business_imports, :business_count, :integer
  end
end
