class ApplicationController < ActionController::Base
    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, alert: exception.message
    end

    def current_ability
      @current_ability ||= Ability.new(current_account)
    end

  private
  def authenticate
    rodauth.require_account # redirect to login page if not authenticated
  end
end