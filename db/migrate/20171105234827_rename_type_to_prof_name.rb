# frozen_string_literal: true

class RenameTypeToProfName < ActiveRecord::Migration[5.0]
  def change
    return unless column_exists?(:templates, :type)

    rename_column :templates, :type, :prof_name
  end
end
