class Endpoint < ApplicationRecord
  after_save :register
  after_destroy :unregister

  private

  def register
    Endpoints::Router.register_endpoint self.id
  end

  def unregister
    Endpoints::Router.unregister_endpoint self.id
  end
end
