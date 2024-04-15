class Api::AccountsController < ApplicationController
  protect_from_forgery with: :null_session

  TOKEN = "secret"

  before_action :authenticate_token

  def create
    account = Account.new(account_params)

    RodauthApp.rodauth.create_account(login: "user@example.com", password: "secret123", full_name: "John Doe", birth_date: "1990-01-01", permament_address: "123 Main St", phone: "123-456-7890", member_code: "123456")

    # if account.save
    #   render json: { status: 'success', message: 'Account created', data: account }, status: :created
    # else
    #   render json: { status: 'error', message: account.errors.full_messages }, status: :unprocessable_entity
    # end
  end

  # /api/accounts/:id
  def update
    account = Account.find_by(id: params[:id])
    if account.nil?
      render json: { status: 'error', message: 'Account not found' }, status: :not_found
    else
      if account.update(account_params)
        render json: { status: 'success', message: 'Account updated', data: account }, status: :ok
      else
        render json: { status: 'error', message: account.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  # Delete an account
  def destroy
    account = Account.find_by(id: params[:id])
    if account.nil?
      render json: { status: 'error', message: 'Account not found' }, status: :not_found
    else
      account.destroy
      render json: { status: 'success', message: 'Account deleted' }, status: :ok
    end
  end

  private

  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
    end
  end

  def account_params
    params.require(:account).permit(:email, :password, :full_name, :birth_date, :permament_address, :phone, :member_code)
  end
end
