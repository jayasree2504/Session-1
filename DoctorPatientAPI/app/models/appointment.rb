# app/models/appointment.rb
class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :appointment_date, presence: true
  validate :appointment_not_in_past

  scope :upcoming, -> { where('appointment_date > ?', Time.now) }

  private

  def appointment_not_in_past
    errors.add(:appointment_date, "can't be in the past") if appointment_date < Time.now
  end
end
