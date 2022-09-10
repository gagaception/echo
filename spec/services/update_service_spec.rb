RSpec.describe Endpoints::UpdateService, type: :service do
  describe '#call' do
    let(:endpoint_params) {{ 
      verb: 'GET', 
      path: '/foo', 
      response: { 
        "code": 200, 
        "headers": {'Content-Type': 'application/json'}, 
        "body": "foobar" 
      } 
    }}

    subject { described_class.new }

    context 'when the endpoint exist' do
      let(:endpoint) { create(:endpoint) }
      
      it 'should update the endpoints verb and path' do
        expect {
          subject.call(endpoint_params: endpoint_params, endpoint_id: endpoint.id)
        }.to change { endpoint.reload.verb }.from(endpoint.verb).to(endpoint_params[:verb])
         .and change { endpoint.reload.path }.from(endpoint.path).to(endpoint_params[:path])
      end
    end

    context 'when the endpoint exist & invalid params' do
      let(:endpoint) { create(:endpoint) }
      let(:endpoint_params) {{}}

      it 'should update the endpoints verb and path' do
        result = subject.call(endpoint_params: endpoint_params, endpoint_id: endpoint.id)
        expect(result.success?).to be_falsey
      end
    end
  end
end