# spec/models/doctor_spec.rb
require 'rails_helper'

RSpec.describe Doctor, type: :model do
  it { should belong_to(:clinic) }
  it { should have_many(:appointments) }
  it { should have_many(:patients).through(:appointments) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:specialization) }
  it { should validate_presence_of(:clinic) }

  it "should have a valid specialization enum" do
    expect(Doctor.specializations.keys).to include('general', 'cardiologist', 'neurologist', 'dentist')
  end

  it "should trigger a callback after create" do
    doctor = FactoryBot.build(:doctor)
    expect(doctor).to receive(:send_welcome_email)
    doctor.save
  end
end
