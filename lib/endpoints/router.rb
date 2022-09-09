module Endpoints
  class Router
    METHODS = [:get, :post, :put, :patch, :delete, :options, :head].freeze

    REGISTERED_ENDPOINT_IDS = []

    class << self
      def load_endpoints_routes!
        Endpoint.all.each { |endpoint| REGISTERED_ENDPOINT_IDS << endpoint.id }

        endpoints = REGISTERED_ENDPOINT_IDS.map do |endpoint_id|
          Endpoint.find endpoint_id
        end

        endpoints.each do |endpoint|
          define_route endpoint
        end
      end

      def reload_routes!
        Echo::Application.routes_reloader.reload!
      end

      def register_endpoint(endpoint)
        REGISTERED_ENDPOINT_IDS << endpoint.id
        REGISTERED_ENDPOINT_IDS.uniq!
        reload_routes!
      end

      def unregister_endpoint(endpoint)
        REGISTERED_ENDPOINT_IDS.delete endpoint.id
        reload_routes!
      end


      private

      def define_route(endpoint)
        Echo::Application.routes.draw do
          self.send(
            :match,
            endpoint.path,
            to: 'endpoints#serve_mock_endpoint',
            defaults: { mock_endpoint_id: endpoint.id },
            via: endpoint.verb
          )
        end
      end
    end
  end
end