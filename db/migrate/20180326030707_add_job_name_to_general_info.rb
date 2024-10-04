# frozen_string_literal: true

class AddJobNameToGeneralInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :general_infos, :job_name, :string
  end
end
