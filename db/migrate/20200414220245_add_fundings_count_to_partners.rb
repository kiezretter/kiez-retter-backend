class AddFundingsCountToPartners < ActiveRecord::Migration[6.0]
  def change
    add_column :partners, :fundings_count, :integer
  end
end
