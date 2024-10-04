# frozen_string_literal: true

class AddGalleryIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :gallery, null: false, foreign_key: true
  end
end
