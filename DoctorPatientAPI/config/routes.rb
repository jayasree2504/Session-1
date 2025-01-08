# config/routes.rb
Rails.application.routes.draw do
  devise_for :admin_users
  resources :clinics
  resources :doctors
  resources :patients
  resources :appointments

  # This will generate routes like:
  # GET /clinics, POST /clinics, GET /clinics/:id, PUT /clinics/:id, DELETE /clinics/:id
  # GET /doctors, POST /doctors, GET /doctors/:id, PUT /doctors/:id, DELETE /doctors/:id
  # GET /patients, POST /patients, GET /patients/:id, PUT /patients/:id, DELETE /patients/:id
  # GET /appointments, POST /appointments, GET /appointments/:id, PUT /appointments/:id, DELETE /appointments/:id
end
