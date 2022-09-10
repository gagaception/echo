RSpec.describe ServeEndpointsController, type: :controller do
  describe '#serve_mock_endpoint' do
    let(:endpoint) { create(:endpoint) }

    it 'should return the endpoint response' do
      get :serve_mock_endpoint, params: { endpoint_id: endpoint.id }
      expect(response.body).to eq endpoint.response.to_json
    end
  end
end