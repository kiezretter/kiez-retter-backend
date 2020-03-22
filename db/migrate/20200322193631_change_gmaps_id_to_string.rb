class ChangeGmapsIdToString < ActiveRecord::Migration[6.0]
  def change
    change_column :businesses, :gmap_id, :string
  end
end
