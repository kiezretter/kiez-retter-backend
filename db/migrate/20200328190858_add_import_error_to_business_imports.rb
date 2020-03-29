class AddImportErrorToBusinessImports < ActiveRecord::Migration[6.0]
  def change
    add_column :business_imports, :import_error, :text
  end
end
