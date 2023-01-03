# frozen_string_literal: true

# This shiny device polishes bared foos
class Bus < ApplicationRecord
  has_one_attached :bus_photo
  validate :avatar_size_validation
  validate :image_type

  private

  def image_type
    errors.add(:bus_photo, 'is missing!') if bus_photo.attached? == false
    return if bus_photo.content_type.in?(%('image/jpeg image/png '))

    errors.add(:bus_photo, 'needs to be a jpeg or png!')
  end

  def avatar_size_validation
    return unless bus_photo.byte_size > 2.megabytes

    errors.add(:bus_photo, message: 'file size should be less than 2 MB')
  end
end
