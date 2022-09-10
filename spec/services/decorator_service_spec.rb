RSpec.describe Endpoints::DecoratorService, type: :service do
  describe '#call' do
    let(:endpoint) { create(:endpoint) }

    it 'should return a hash with the endpoint attributes' do
      result = described_class.new(endpoint).call
      expect(result).to eq(
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
      )
    end
  end
end