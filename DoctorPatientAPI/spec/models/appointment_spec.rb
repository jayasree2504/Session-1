# spec/models/appointment_spec.rb
require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  let!(:doctor) { FactoryBot.create(:doctor) }
  let!(:patient) { FactoryBot.create(:patient) }

  describe "POST /appointments" do
    it "creates a new appointment" do
      appointment_params = { doctor_id: doctor.id, patient_id: patient.id, appointment_date: 1.day.from_now }
      post appointments_path, params: { appointment: appointment_params }
      expect(response).to have_http_status(:created)
      expect(Date.parse(JSON.parse(response.body)['appointment_date'])).to eq(1.day.from_now.to_date)
    end
  end
end
