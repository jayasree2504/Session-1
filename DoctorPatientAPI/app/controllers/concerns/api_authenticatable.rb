# app/controllers/concerns/api_authenticatable.rb
module ApiAuthenticatable
    extend ActiveSupport::Concern
  
    included do
      before_action :authenticate_request!
      helper_method :current_admin if respond_to?(:helper_method)
    end
  
    private
  
    def authenticate_request!
      api_key = request.headers['X-API-Key']
      unless api_key
        render json: { error: 'API key missing' }, status: :unauthorized
        return
      end
  
      @current_admin = AdminUser.find_by(api_key: api_key)
      unless @current_admin
        render json: { error: 'Invalid API key' }, status: :unauthorized
        return
      end
    end
  
    def current_admin
      @current_admin
    end
  end