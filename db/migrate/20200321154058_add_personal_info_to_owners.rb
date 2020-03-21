# frozen_string_literal: true

class AddPersonalInfoToOwners < ActiveRecord::Migration[6.0]
  def change
    add_column :owners, :nick_name, :string
    add_column :owners, :salutation, :string
    add_column :owners, :last_name, :string
    add_column :owners, :first_name, :string
  end
end
