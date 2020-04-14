class ResetFundingsCountOnPartners < ActiveRecord::Migration[6.0]
  def change
    Partner.find_each do |partner|
      Partner.reset_counters(partner.id, :fundings)
    end
  end
end
