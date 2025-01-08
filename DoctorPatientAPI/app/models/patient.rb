# app/models/patient.rb
class Patient < ApplicationRecord
    has_many :appointments, dependent: :destroy
    has_many :doctors, through: :appointments
  
    validates :name, presence: true
    validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :email, presence: true, uniqueness: true, 
              format: { with: URI::MailTo::EMAIL_REGEXP }
  end
  