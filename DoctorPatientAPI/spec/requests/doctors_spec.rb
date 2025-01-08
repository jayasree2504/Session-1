# spec/requests/doctors_spec.rb
require 'rails_helper'

RSpec.describe "Doctors", type: :request do
  let!(:clinic) { FactoryBot.create(:clinic) }

  describe "POST /doctors" do
    it "creates a new doctor" do
      doctor_params = { name: "Dr. John", specialization: "Cardiologist", clinic_id: clinic.id }
      post doctors_path, params: { doctor: doctor_params }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq("Dr. John")
    end
  end

  describe "GET /doctors" do
    it "returns a list of doctors" do
      FactoryBot.create_list(:doctor, 3, clinic: clinic)
      get doctors_path
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end
end
