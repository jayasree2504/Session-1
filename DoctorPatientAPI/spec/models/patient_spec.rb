# spec/models/patient_spec.rb
require 'rails_helper'

RSpec.describe Patient, type: :model do
  it { should have_many(:appointments) }
  it { should have_many(:doctors).through(:appointments) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:age) }
  it { should validate_numericality_of(:age).only_integer.is_greater_than(0) }
end
