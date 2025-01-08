# spec/factories/clinics.rb
FactoryBot.define do
  factory :clinic do
    name { "Default Clinic" }
    address { "123 Default St" }
  end
end