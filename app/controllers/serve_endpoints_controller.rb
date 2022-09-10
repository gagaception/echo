class ServeEndpointsController < ApplicationController
  def serve_mock_endpoint
    endpoint = Endpoint.find(params[:endpoint_id])
    render json: endpoint.response.to_json
  end
end
