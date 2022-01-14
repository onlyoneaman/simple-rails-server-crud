class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  include ErrorsHelper
  include ApplicationHelper

  rescue_from StandardError, with: :handle_internal_error
  rescue_from BaseError::NotFound, with: :handle_not_found
  rescue_from BaseError::Unauthorized, with: :handle_unauthorized
  rescue_from BaseError::Forbidden, with: :handle_forbidden
  rescue_from BaseError::BadRequest, with: :handle_bad_request
  rescue_from BaseError::InternalError, with: :handle_internal_error
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  rescue_from ActionController::ParameterMissing, with: :handle_missing_parameters

  def success_response(data)
    {
      data: data,
      success: true,
      error: nil
    }
  end

  def handle_missing_parameters(exception)
    Rails.logger.error("Missing Parameter Error Response: #{exception.message}")
    render json: error_response(:parameter_missing,
                                exception.message,
                                I18n.t('errors.bad_request.params_missing')),
           status: :bad_request
  end

  def handle_internal_error(exception)
    Rails.logger.error("Internal Error: #{exception.message}")
    render json: error_response(:internal_server_error,
                                exception.message,
                                I18n.t('errors.internal_server_error.title')),
           status: :internal_server_error
  end

  def handle_record_invalid(exception)
    Rails.logger.error("Unprocessable Entity error: #{exception.message}")
    render json: error_response(:unprocessable_entity,
                                exception.message,
                                I18n.t('errors.unprocessable_entity.title')),
           status: :unprocessable_entity
  end

  def handle_not_found(exception)
    Rails.logger.info("Not Found Error: #{exception.message}")
    render json: error_response(:record_not_found,
                                exception.message,
                                I18n.t('errors.not_found.title')),
           status: :not_found
  end

  def handle_bad_request(exception)
    Rails.logger.error("Bad Request Error: #{exception.message}")
    render json: error_response(:bad_request,
                                exception.message,
                                I18n.t('errors.bad_request.title')),
           status: :bad_request
  end


  def handle_unauthorized(exception)
    Rails.logger.error("UnAuthorised Error: #{exception.message}")
    render json: error_response(:permission_denied,
                                exception.message,
                                I18n.t('errors.unauthorised.title')),
           status: :unauthorized
  end

  def handle_forbidden(exception)
    Rails.logger.error("Bad Request Error: #{exception.message}")
    render json: error_response(:bad_request,
                                exception.message,
                                I18n.t('errors.forbidden.title')),
           status: :forbidden
  end

end
