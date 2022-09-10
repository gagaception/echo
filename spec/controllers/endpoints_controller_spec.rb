require 'rails_helper'

RSpec.describe EndpointsController, type: :controller do
  let(:endpoint_params) {{ 
    verb: 'GET', 
    path: '/foo', 
    response: { 
      "code": 200, 
      "headers": {'Content-Type': 'application/json'}, 
      "body": "foobar" 
    } 
  }}

  before do
    Endpoints::Router.reset!  
  end

  describe '#index' do
    it 'should return a list of endpoints' do
      endpoint = create(:endpoint)
      get :index
      expect(response.body).to eq [Endpoints::DecoratorService.new(endpoint).result].to_json
    end

    it 'should return [] when no Endpoints' do
      get :index
      expect(response.body).to eq [].to_json
    end
  end

  describe '#create' do
    context "when params are valid" do
      it 'should create the endpoint with valid params' do
        post :create, params: { endpoint: endpoint_params }
        expect(response).to be_successful
      end
    end

    context "when params are invalid" do
      let(:endpoint_params) {{ 
        verb: 2321, 
        path: '/foo', 
        response: { 
          "code": 200, 
          "headers": {'Content-Type': 'application/json'}, 
          "body": "foobar" 
        } 
      }}

      it 'should return failure with valid params' do
        post :create, params: { endpoint: endpoint_params }
        expect(response).to_not be_successful
      end
    end
  end

  describe '#update' do
    let(:endpoint) { create(:endpoint) }

    context "when params are valid" do
      it 'should update the endpoint with valid params' do
        patch :update, params: { id: endpoint.id, endpoint: endpoint_params }
        expect(response).to be_successful
      end
    end

    context "when params are invalid" do
      let(:endpoint_params) {{ 
        verb: 2321, 
        path: '/foo', 
        response: { 
          "code": 200, 
          "headers": {'Content-Type': 'application/json'}, 
          "body": "foobar" 
        } 
      }}

      it 'should return failure with valid params' do
        patch :update, params: { id: endpoint.id, endpoint: endpoint_params }
        expect(response).to_not be_successful
      end
    end
  end
  
  describe '#destroy' do
    let(:endpoint) { create(:endpoint) }

    it 'should delete the endpoint' do
      delete :destroy, params: { id: endpoint.id }
      expect(response).to be_successful
    end

    it 'should return failure when endpoint does not exist' do
      delete :destroy, params: { id: endpoint.id + 1 }
      expect(response).to_not be_successful
    end
  end
end