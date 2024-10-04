# frozen_string_literal: true

class CreateCollaborations < ActiveRecord::Migration[6.1]
  def change
    create_table :collaborations do |t|
      t.bigint :general_info_id, null: false
      t.bigint :collaborator_id, null: false

      t.timestamps
    end

    add_index :collaborations, %i[general_info_id collaborator_id], unique: true
  end
end
