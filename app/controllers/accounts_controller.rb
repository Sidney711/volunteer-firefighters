class AccountsController < ApplicationController
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

  def update
    if !rodauth.rails_account.is_super_admin && account_params[:is_super_admin]
      redirect_to accounts_url, alert: "You do not have permission to make someone superadmin."
    else
      if @account.update(account_params)
        redirect_to @account, notice: 'Account was successfully updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  private

  def account_params
    params.require(:account).permit(:full_name, :birth_date, :permament_address, :phone, :member_code, :is_super_admin,
                                    account_awards_attributes: [:id, :award_id, :_destroy])
  end
end