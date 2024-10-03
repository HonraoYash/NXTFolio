# frozen_string_literal: true

class Room < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_rooms, -> { where(is_private: false) }
  has_many :messages

  def self.create_private_room(_users, room_name)
    Room.create(name: room_name)
  end
end
