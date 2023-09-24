# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
    # rubocop:disable Lint/UselessMethodDefinition
    def create
      super
    end

    def update
      super
    end

    # rubocop:enable Lint/UselessMethodDefinition
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: %i[full_name])
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[full_name])
    end
  end
end
