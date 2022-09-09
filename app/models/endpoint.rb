class Endpoint < ApplicationRecord
  validates :verb, :path, :response, presence: true

  after_save :register
  after_destroy :unregister

  private

  def register
    Endpoints::Router.register_endpoint self
  end

  def unregister
    Endpoints::Router.unregister_endpoint self
  end
end
