class CreatePartnersForExistingFundings < ActiveRecord::Migration[6.0]
  def up
    Funding
      .where(partner_id: nil)
      .find_each do |funding|
        funding.create_partner_if_not_exist
        funding.save!
    end
  end
end
