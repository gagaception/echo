module Endpoints
  class UpdateService < Builders::EndpointBuilder
    include Dry::Monads[:result, :do]

    class Schema < Builders::EndpointBuilder::Schema
      params do
        required(:endpoint_id).filled(:integer)
      end
    end
    
    def call(params)
      result = yield validate(params)

      endpoint = Endpoint.find(result[:endpoint_id])
      endpoint.update(result[:endpoint_params])
    
      Success(Endpoints::DecoratorService.new(endpoint).call)
    end
  end
end