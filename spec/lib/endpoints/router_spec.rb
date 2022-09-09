require 'rails_helper'

module Endpoints
  RSpec.describe Router do
    it 'should have default methods' do
      expect(Router::METHODS).to eq [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end
end