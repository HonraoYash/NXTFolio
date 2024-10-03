# frozen_string_literal: true

class AddGalleryFileToGallery < ActiveRecord::Migration[5.0]
  def change
    add_column :galleries, :gallery, :string
  end
end
