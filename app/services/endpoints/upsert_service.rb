module Endpoints
  class UpsertService
    include Dry::Monads[:result, :do]

    ALLOWED_METHODS = ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS", "HEAD"].freeze

    class Schema < Dry::Validation::Contract
      params do
        required(:endpoint_params).hash do
          required(:verb).filled(:string)
          required(:path).filled(:string)
          required(:response).hash do
            required(:code).filled(:integer)
            required(:body).filled(:string)
            optional(:headers).filled(:hash)
          end
        end
        optional(:endpoint_id).filled(:integer)
      end

      rule(endpoint_params: :verb) do
        key.failure("invalid verb") unless value.in? ALLOWED_METHODS
      end
    end
    
    def call(params)
      result = yield validate(params)

      if result[:endpoint_id]
        endpoint = Endpoint.find(result[:endpoint_id])
        if endpoint
          endpoint.update(result[:endpoint_params])
        else
          raise StandardError
        end
      else
        endpoint = Endpoint.create(result[:endpoint_params])
      end
    
      Success(Endpoints::DecoratorService.new(endpoint).call)
    end

    private

    def validate(payload)
      result = self.class::Schema.new.call(payload)
      result.success? ? Success(result.to_h) : Failure(result.errors.to_h)
    end
  end
end