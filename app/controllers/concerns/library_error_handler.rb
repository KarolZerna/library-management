# frozen_string_literal: true

module LibraryErrorHandler
  class BaseError < StandardError
    attr_reader :errors, :original_error
  
    def initialize(message: nil, errors: [], original_error: nil)
      super(message)
      @errors = errors
      @original_error = original_error
      set_backtrace(original_error&.backtrace) if original_error
    end

    def http_status_code
        :internal_server_error
    end
  
    def original_error_formatted
        original_error&.message.to_s
    end
  
    def formatted_errors
      return errors if errors&.present?
      return [message] if message&.present?
      end
  
    def to_response
      result = { errors: formatted_errors }
      result[:original_error] = original_error_formatted if original_error&.present?
      result
    end
  end
  
  class SystemError < BaseError
  end
  
  class ClientError < BaseError
    def http_status_code
      :bad_request
    end

    def formatted_errors
      errors.map do |error|
        attribute, message = error.split(" ", 2)
        { attribute: attribute.downcase, message: message }
      end
    end

    def to_response
      {
        errors: formatted_errors,
        errorCode: http_status_code,
        errorMessage: message || "A client error occurred"
      }
    end
  end
  
  class ArgumentError < ClientError
  end
  
  class DataNotFound < BaseError
    def http_status_code
      :not_found
    end
  end
end
