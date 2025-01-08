# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
    include ApiAuthenticatable
  
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  
    private
  
    def not_found_response(error)
      render json: { error: error.message }, status: :not_found
    end
  end