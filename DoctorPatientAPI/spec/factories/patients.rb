# spec/factories/patients.rb
FactoryBot.define do
  factory :patient do
    name { "John Doe" }
    age { 30 }
  end
end