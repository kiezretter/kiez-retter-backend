class AddBusinessImportIdToBusinesses < ActiveRecord::Migration[6.0]
  def change
    add_reference :businesses, :business_import, foreign_key: true
  end
end
