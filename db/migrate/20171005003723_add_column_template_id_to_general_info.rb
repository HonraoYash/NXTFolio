# frozen_string_literal: true

class AddColumnTemplateIdToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :template_id, :int
  end
end
