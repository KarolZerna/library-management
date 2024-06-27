# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # rubocop:disable Lint/UnusedMethodArgument
  def respond_with(resource, options = {})
    if resource.persisted?
      render json: {
        status: {
          code: 200,
          message: 'Signed up successfully'
        },
        data: resource
      }, status: :ok
    else
      render json: {
        status: {
          message: 'User could not be created',
          errors: resource.errors.full_messages
        }
      }, status: :unprocessable_entity
    end
  end
  # rubocop:enable Lint/UnusedMethodArgument

  protected

  # rubocop:disable Style/SymbolArray
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :role])
  end
  # rubocop:enable Style/SymbolArray
end
# rubocop:enable Style/ClassAndModuleChildren
