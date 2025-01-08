# spec/requests/clinics_spec.rb
require 'rails_helper'

RSpec.describe "Clinics", type: :request do
  describe "GET /clinics" do
    it "returns a list of clinics" do
      FactoryBot.create_list(:clinic, 3)
      get clinics_path
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "POST /clinics" do
    it "creates a new clinic" do
      clinic_params = { name: "New Clinic", address: "123 Main St" }
      post clinics_path, params: { clinic: clinic_params }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq("New Clinic")
    end
  end
end
