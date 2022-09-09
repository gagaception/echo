class EndpointsController < ApplicationController
  before_action :load_endpoint, only: [:update, :destroy]
  after_action :reload_routes, only: [:update, :create, :destroy]

  def index
    render json: Endpoint.all
  end

  def create
    endpoint = Endpoint.new(endpoint_params)
    if endpoint.save
      render json: endpoint
    else
      @skip_reloading = true
      render json: { errors: endpoint.errors.full_messages }, status: 422
    end
  end

  def update
    if @endpoint.update(endpoint_params)
      render json: @endpoint
    else
      @skip_reloading = true
      render json: { errors: @endpoint.errors.full_messages }, status: 422
    end
  end

  def destroy
    @endpoint.destroy
    render json: { message: "Endpoint successfully deleted" }
  end

  def serve_mock_endpoint
    mock_endpoint = Endpoint.find params[:mock_endpoint_id]

    render json: mock_endpoint
  end

  private

  def endpoint_params
    params.require(:data).permit(attributes: [:verb, :path, response: [:code, :body, headers: {}]])
  end

  def load_endpoint
    @endpoint = Endpoint.find(params[:id])
  end

  def reload_routes
    Endpoints::Router.reload_routes! unless @skip_reloading
  end
end