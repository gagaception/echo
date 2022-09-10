require 'rails_helper'

RSpec.describe Endpoints::UpsertService, type: :service do
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
    
    context 'when the endpoint is new & valid params' do
      it 'should create the endpoint' do
        expect {
          subject.call(endpoint_params: endpoint_params)
        }.to change(Endpoint, :count).by(1)
      end

      it 'should return success' do
        result = subject.call(endpoint_params: endpoint_params)
        expect(result.success?).to be_truthy
      end
    end

    context 'when the endpoint is new & invalid params' do
      let(:endpoint_params) {{}}

      it 'should return failure' do
        result = subject.call(endpoint_params: endpoint_params)
        expect(result.success?).to be_falsey
      end
    end

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