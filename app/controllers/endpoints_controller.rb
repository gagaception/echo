class EndpointsController < ApplicationController
  after_action :reload_routes, only: [:update, :create, :destroy]

  def index
    endpoints = Endpoint.all.map do |endpoint|
      Endpoints::DecoratorService.new(endpoint).result
    end
    render json: endpoints
  end

  def create
    endpoint = Endpoints::UpsertService.new.call(
      endpoint_params: endpoint_params.to_h,
    )

    if endpoint.success?
      render json: endpoint.success
    else
      @skip_reloading = true
      render json: { errors: endpoint.failure }, status: 422
    end
  end

  def update
    endpoint = Endpoints::UpsertService.new.call(
      endpoint_params: endpoint_params.to_h,
      endpoint_id: params[:id].to_i,
    )

    if endpoint.success?
      render json: endpoint.success
    else
      @skip_reloading = true
      render json: { errors: endpoint.failure }, status: 422
    end
  rescue ActiveRecord::RecordNotFound
    record_not_found
  end

  def destroy
    endpoint = Endpoint.find(params[:id])
    endpoint.destroy
    render json: { message: "Endpoint successfully deleted" }
  rescue ActiveRecord::RecordNotFound
    record_not_found
  end

  def serve_mock_endpoint
    render json: Endpoint.find(params[:mock_endpoint_id])
  end

  private

  def endpoint_params
    params.require(:endpoint).permit(:verb, :path, response: {})
  end

  def reload_routes
    Endpoints::Router.reload_routes! unless @skip_reloading
  end

  def record_not_found
    render json: { errors: [{ code: "not_found", detail: "Requested Endpoint with ID #{params[:id]} does not exist" }] }, status: 404
  end
end