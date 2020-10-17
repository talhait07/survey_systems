class Api::ApiBaseController < ApplicationController
  rescue_from ActionController::RoutingError do |error|
    render status: 404, json: {error: error.message}
  end

  rescue_from Exception do |error|
    render status: 500, json: {error: error.message}
  end


  rescue_from ActiveRecord::RecordInvalid do |error|
    render status: 422, json: {error: error.message}
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    render status: 404, json: {error: error.message}
  end
end