class AccountsController < ApplicationController
  before_action :authenticate
  load_and_authorize_resource

  def create
    @account = Account.new(account_params)

    if @account.save
      send_verification_email(@account)
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  private

  def account_params
    params.require(:account).permit(:email, :full_name, :birth_date, :permament_address, :phone, :member_code, :is_super_admin)
  end
end