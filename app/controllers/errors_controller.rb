class ErrorsController < ApplicationController
  def error_404
    render json: {
      "errors": [
        {
          "code": "not_found",
          "detail": "Requested page /#{request[:path]} does not exist"
        }
      ]
    }, status: 404
  end
end
