# frozen_string_literal: true

class AddIndexForLatAndLng < ActiveRecord::Migration[6.0]
  def change
    add_index(:businesses, %i[lat lng], name: 'index_businesses_on_lat_lng')
  end
end
