# frozen_string_literal: true

class ChangeTradeCertificates < ActiveRecord::Migration[6.0]
  def change
    remove_column :trade_certificates, :verified
    rename_column :trade_certificates, :owner_id, :business_id
  end
end
