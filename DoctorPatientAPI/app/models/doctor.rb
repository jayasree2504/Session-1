# app/models/doctor.rb
class Doctor < ApplicationRecord
  belongs_to :clinic
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  validates :name, presence: true
  validates :specialization, presence: true
  validates :clinic, presence: true

  # Fix the enum definition
  enum :specialization, {
    general: 'General',
    cardiologist: 'Cardiologist',
    neurologist: 'Neurologist',
    dentist: 'Dentist'
  }, default: 'general'

  # Callback to notify when a doctor is created
  after_create :send_welcome_email

  private

  def send_welcome_email
    # Here you can call a method to send a welcome email or any other action.
    puts "Sending welcome email to Dr. #{name}"
  end
end