# spec/factories/doctors.rb
FactoryBot.define do
  factory :doctor do
    name { "Dr. Smith" }
    specialization { "Cardiologist" }
    association :clinic
  end
end