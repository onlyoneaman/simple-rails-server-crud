module ErrorsHelper

  def error_response(status, error_message, title)
    error_object = ErrorObject.new
    error_object.errors.add(status, error_message)
    error_response_for(error_object, title)
  end

  def error_response_for(obj, title, severity = 'error')
    errors = []
    obj.errors.each do |attr, message|
      errors << { code: "#{Figaro.env.app_name.camelize}_#{attr.to_s.camelize}",
                  message: obj.errors.full_message(:base, message),
                  message_title: title,
                  message_severity: severity }
    end
    { data: nil, success: false, errors: errors }
  end

  class RaiseError
    class << self
      def from_status_code(status_code, message)
        if status_code == 401 || status_code == 403
          raise BaseError::InternalError.new(message)
        elsif status_code == 404
          raise BaseError::NotFound.new(message)
        elsif status_code == 400
          raise BaseError::BadRequest.new(message)
        elsif status_code == 422
          raise BaseError::UnprocessableEntityError.new(message)
        elsif status_code == 429
          raise BaseError::RateLimit.new(message)
        else
          raise BaseError::InternalError.new(message)
        end
      end
    end
  end
end
