class CreatePartnersForExistingFundings < ActiveRecord::Migration[6.0]
  def up
    Funding
      .where(partner_id: nil)
      .find_each(&:create_partner_if_not_exist)
  end
end
