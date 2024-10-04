# frozen_string_literal: true

class AddUserKeyToSpecificPhotographers < ActiveRecord::Migration[5.0]
  def change
    add_column :specific_photographers, :user_key, :string
  end
end
