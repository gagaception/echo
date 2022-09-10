module Builders
  class EndpointBuilder
    ALLOWED_METHODS = ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS", "HEAD"].freeze

    class Schema < Dry::Validation::Contract
      params do
        required(:endpoint_params).hash do
          required(:verb).filled(:string)
          required(:path).filled(:string)
          required(:response).hash do
            required(:code).filled(:integer)
            required(:body).filled(:string)
            optional(:headers)
          end
        end
      end

      rule(endpoint_params: :verb) do
        key.failure("invalid verb") unless value.in? ALLOWED_METHODS
      end
    end

    def validate(payload)
      result = self.class::Schema.new.call(payload)
      result.success? ? Success(result.to_h) : Failure(result.errors.to_h)
    end
  end
end