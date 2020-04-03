class AddErrorToDeadLink < ActiveRecord::Migration[6.0]
  def change
    add_column :dead_links, :error_msg, :string
  end
end
