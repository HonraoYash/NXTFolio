# frozen_string_literal: true

class AddUserKeyToSpecificModels < ActiveRecord::Migration[5.0]
  def change
    add_column :specific_models, :user_key, :string
  end
end
