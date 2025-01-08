# spec/factories/appointments.rb
FactoryBot.define do
  factory :appointment do
    appointment_date { 1.day.from_now }
    association :doctor
    association :patient
  end
end