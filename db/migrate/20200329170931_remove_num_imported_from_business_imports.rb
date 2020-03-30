# frozen_string_literal: true

class RemoveNumImportedFromBusinessImports < ActiveRecord::Migration[6.0]
  def change
    remove_column :business_imports, :num_imported
  end
end
