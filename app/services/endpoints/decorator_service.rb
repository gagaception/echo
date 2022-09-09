module Endpoints
  class DecoratorService < SimpleDelegator
    def initialize(endpoint)
      @endpoint = endpoint
    end

    def result
      {
        data: {
          type: 'endpoints',
          id: endpoint.id,
          attributes: {
            verb: endpoint.verb,
            path: endpoint.path,
            response: {
              code: endpoint.response["code"],
              headers: endpoint.response["headers"],
              body: endpoint.response["body"]
            }
          }
        }
      }
    end

    private

    attr_reader :endpoint
  end
end