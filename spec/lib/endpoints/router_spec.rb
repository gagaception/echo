require 'rails_helper'

module Endpoints
  RSpec.describe Router do
    it 'should have default methods' do
      expect(Router::METHODS).to eq [:get, :post, :put, :patch, :delete, :options, :head]
    end

    before do
      Router.reset!
    end

    describe 'REGISTERED_ENDPOINT_IDS' do
      context 'when there are no registered endpoints' do
        it 'should be an empty array' do
          expect(Router::REGISTERED_ENDPOINT_IDS).to eq []
        end
      end

      context 'when there are registered endpoints' do
        let(:endpoint) { create(:endpoint) }

        it 'should be an array of endpoint ids' do
          expect(Router::REGISTERED_ENDPOINT_IDS).to eq [endpoint.id]
        end
      end
    end

    describe '.load_endpoints_routes!' do
      let(:endpoint) { create(:endpoint) }

      it 'should load the routes for the registered endpoints' do
        expect(Router).to receive(:define_route).with(endpoint)

        Router.load_endpoints_routes!
      end
    end

    describe '.register_existing_endpoint' do
      let(:endpoint) { create(:endpoint) }

      it 'should register the endpoint' do
        Router.register_existing_endpoint

        expect(Router::REGISTERED_ENDPOINT_IDS).to eq [endpoint.id]
      end
    end

    describe '.register_endpoint' do
      let(:endpoint) { create(:endpoint) }

      it 'should register the endpoint' do
        Router.register_endpoint(endpoint.id)

        expect(Router::REGISTERED_ENDPOINT_IDS).to eq [endpoint.id]
      end
    end

    describe '.unregister_endpoint' do
      let(:endpoint) { create(:endpoint) }

      it 'should unregister the endpoint' do
        Router.register_endpoint(endpoint.id)
        Router.unregister_endpoint(endpoint.id)

        expect(Router::REGISTERED_ENDPOINT_IDS).to eq []
      end
    end

    describe '.reload_routes!' do
      it 'should reload the routes' do
        expect(Echo::Application.routes_reloader).to receive(:reload!)

        Router.reload_routes!
      end
    end

    describe '.reset!' do
      let(:endpoint) { create(:endpoint) }

      it 'should reset the router' do
        Router.register_existing_endpoint

        Router.reset!

        expect(Router::REGISTERED_ENDPOINT_IDS).to eq []
      end
    end
  end
end