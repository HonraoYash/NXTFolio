# frozen_string_literal: true

class Tag < ApplicationRecord
  belongs_to :gallery
  validates_presence_of :body
end
