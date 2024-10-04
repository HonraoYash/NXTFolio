# frozen_string_literal: true

class AddUserKeyToJobInfos < ActiveRecord::Migration[6.1]
  def change
    add_column :job_infos, :userKey, :string
  end
end
