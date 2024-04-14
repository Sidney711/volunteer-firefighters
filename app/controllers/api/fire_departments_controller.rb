class Api::FireDepartmentsController < ApplicationController
  TOKEN = "secret"

  before_action :authenticate_token

  def index
    @fire_departments = FireDepartment.all
    render json: @fire_departments
  end

  private

  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
    end
  end
end
