# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::InvalidAuthenticityToken, with: :redirect_to_referer_or_path
  before_action :authenticate_user!


  protected

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  def authenticate_inviter!
    redirect_to root_url, alert: 'Only admin can invite other users!' unless current_user.type == 'Admin'
    super
  end

  def redirect_to_referer_or_path
    flash[:alert] = 'Token is invalid!'
    redirect_to request.referer
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:account_update, keys: %i[full_name])
  #   devise_parameter_sanitizer.permit(:sign_up, keys: %i[full_name])
  #   devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[type full_name avatar])
  # end

  def record_not_found
    flash[:alert] = 'There is no such record exists'
    redirect_to root_path
  end
end
