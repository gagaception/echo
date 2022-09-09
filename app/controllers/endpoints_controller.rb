class EndpointsController < ApplicationController
  def index
    render json: Endpoint.all
  end
  
  def create
    endpoint = Endpoint.new(endpoint_params)
    if endpoint.save
      render json: endpoint
    else
      render json: { errors: endpoint.errors.full_messages }, status: 422
    end
  end

  def update
    endpoint = Endpoint.find(params[:id])
    if endpoint.update(endpoint_params)
      render json: endpoint
    else
      render json: { errors: endpoint.errors.full_messages }, status: 422
    end
  end

  def destroy
    endpoint = Endpoint.find(params[:id])
    endpoint.destroy
    render json: { message: "Endpoint successfully deleted" }
  end

  private

  def endpoint_params
    params.require(:endpoint).permit(:verb, :path, response: [:code, :body, headers: {}])
  end
end