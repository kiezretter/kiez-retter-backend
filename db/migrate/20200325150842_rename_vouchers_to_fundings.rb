# frozen_string_literal: true

class RenameVouchersToFundings < ActiveRecord::Migration[6.0]
  def change
    rename_table :vouchers, :fundings
  end
end
