# spec/models/clinic_spec.rb
require 'rails_helper'

RSpec.describe Clinic, type: :model do
  it { should have_many(:doctors).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
end
