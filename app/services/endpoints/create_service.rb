module Endpoints
  class CreateService < Builders::EndpointBuilder
    include Dry::Monads[:result, :do]
    
    def call(params)
      result = yield validate(params)
      endpoint = Endpoint.create(result[:endpoint_params])
    
      Success(Endpoints::DecoratorService.new(endpoint).call)
    end
  end
end