class AddIndexForLatAndLng < ActiveRecord::Migration[6.0]
  def change
    add_index(:businesses, [:lat, :lng], name: "index_businesses_on_lat_lng")
  end
end
