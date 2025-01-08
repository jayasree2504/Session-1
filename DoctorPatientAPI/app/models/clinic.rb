# app/models/clinic.rb
class Clinic < ApplicationRecord
    has_many :doctors, dependent: :destroy
  
    validates :name, presence: true
    validates :address, presence: true
  end
  