# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from StandardError, with: :internal_server_error
  rescue_from LibraryErrorHandler::BaseError, with: :handle_error

  protected

  def handle_error(error)
    Rails.logger.error("Error: #{error.message}\nStacktrace:\n#{error.backtrace.join("\n")}")
    render json: error.to_response, status: error.http_status_code and return
  end

  def internal_server_error_error(error)
    Rails.logger.error("Error: #{error.message}\nStacktrace:\n#{error.backtrace.join("\n")}")
    render json: { error: error.message }, status: :internal_server_error and return
  end

  def render_unauthorized(error_message)
    render json: { error: error_message }, status: :unauthorized
  end
end
