class ErrorsController < ApplicationController
  def show
    render status: :internal_server_error
  end
end
