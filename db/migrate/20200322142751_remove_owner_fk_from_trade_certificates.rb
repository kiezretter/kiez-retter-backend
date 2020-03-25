class RemoveOwnerFkFromTradeCertificates < ActiveRecord::Migration[6.0]
  def up
    remove_foreign_key :trade_certificates, column: :business_id
  end
end