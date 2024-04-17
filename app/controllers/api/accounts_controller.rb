class Api::AccountsController < ApplicationController
  protect_from_forgery with: :null_session

  TOKEN = "secret"

  before_action :authenticate_token

  def create
    begin
      RodauthApp.rodauth.create_account(login: account_params[:email])

      account = Account.find_by(email: account_params[:email])
      if account.update(account_params.except(:email))
        render json: { status: 'success', message: 'Account created', data: account }, status: :ok
      else
        render json: { status: 'error', message: account.errors.full_messages }, status: :unprocessable_entity
      end
    rescue
      render json: { status: 'error', message: 'There was an error with creating account.' }, status: :unprocessable_entity
    end
  end

  # Get all awards from the one account
  def awards
    account = Account.find_by(id: params[:id])
    if account.nil?
      render json: { status: 'error', message: 'Account not found' }, status: :not_found
    else
      render json: { status: 'success', data: account.awards }, status: :ok
    end
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
    params.require(:account).permit(:email, :full_name, :birth_date, :permament_address, :phone, :member_code)
  end
end
