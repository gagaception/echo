require 'swagger_helper'

RSpec.describe 'endpoints', type: :request do
  path '/endpoints' do
    get('list endpoints'.upcase) do
      tags 'Endpoints'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create endpoint'.upcase) do
      tags 'Endpoints'
      consumes 'application/json'
      parameter name: :endpoint, in: :body, schema: {
        type: :object,
        properties: {
          verb: { type: :string, example: 'GET' },
          path: { type: :string, example: '/foo' },
          response: { type: :object, properties: {
            code: { type: :integer, example: 200 },
            headers: { type: :object, example: { 'Content-Type': 'application/json' } },
            body: { type: :string, example: 'foobar' }
          }}
        },
        required: [ 'verb', 'path', 'response' ]
      }

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/endpoints/{id}' do
    # You'll want to customize the parameter types...
    patch('update endpoint'.upcase) do
      tags 'Endpoints'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :endpoint, in: :body, schema: {
        type: :object,
        properties: {
          verb: { type: :string, example: 'GET' },
          path: { type: :string, example: '/foo' },
          response: { type: :object, properties: {
            code: { type: :integer, example: 200 },
            headers: { type: :object, example: { 'Content-Type': 'application/json' } },
            body: { type: :string, example: 'foobar' }
          }}
        },
        required: [ 'verb', 'path', 'response' ]
      }

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete endpoint'.upcase) do
      tags 'Endpoints'
      parameter name: :id, in: :path, type: :string, description: 'id'

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
