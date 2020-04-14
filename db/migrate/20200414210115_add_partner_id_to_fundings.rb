class AddPartnerIdToFundings < ActiveRecord::Migration[6.0]
  def change
    add_reference :fundings, :partner
  end
end
