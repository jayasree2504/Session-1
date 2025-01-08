# config/initializers/rack_attack.rb
class Rack::Attack
    # Throttle all requests by IP (60 requests/minute)
    throttle('req/ip', limit: 60, period: 1.minute) do |req|
      req.ip
    end
  
    # Throttle POST requests to /api/auth by IP address
    throttle('auth/ip', limit: 5, period: 20.seconds) do |req|
      if req.path == '/api/auth' && req.post?
        req.ip
      end
    end
  end