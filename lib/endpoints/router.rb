module Endpoints
  class Router
    METHODS = [:get, :post, :put, :patch, :delete, :options, :head].freeze

    REGISTERED_ENDPOINT_IDS = Endpoint.pluck(:id)

    class << self
      def load_endpoints_routes!
        endpoints = REGISTERED_ENDPOINT_IDS.map do |endpoint_id|
          Endpoint.find endpoint_id
        end

        endpoints.each do |endpoint|
          define_route endpoint
        end
      end

      def register_endpoint(endpoint_id)
        REGISTERED_ENDPOINT_IDS << endpoint_id
        REGISTERED_ENDPOINT_IDS.uniq!
      end

      def unregister_endpoint(endpoint_id)
        REGISTERED_ENDPOINT_IDS.delete endpoint_id
      end

      def reload_routes!
        Echo::Application.routes_reloader.reload!
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