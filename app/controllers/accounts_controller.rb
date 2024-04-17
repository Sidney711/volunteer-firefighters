class AccountsController < ApplicationController
  load_and_authorize_resource
  after_action :broadcast_account, only: [:create, :update, :destroy]

  def index
    @q = Account.accessible_by(current_ability).includes(:fire_departments, :awards).ransack(params[:q])
    @accounts = @q.result(distinct: true)
  end

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
    updater = AccountService.new(
      account: @account,
      account_params: account_params,
      account_awards_params: account_awards_params,
      rodauth: rodauth
    )

    if updater.call
      broadcast_account
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render :edit, alert: 'Account was not updated.'
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  private

  def account_params
    params.require(:account).permit(:full_name, :birth_date, :permament_address, :phone, :member_code, :is_super_admin)
  end

  def account_awards_params
    params.require(:account).permit(account_awards_attributes: [:id, :award_id, :_destroy, :scheduled_at])
  end

  def broadcast_account
    ActionCable.server.broadcast('accounts', {
      action: action_name,
      account: @account.as_json(include: {
        fire_departments: {
          include: {
            memberships: {
              include: :fire_department  # Přidáno pro lepší strukturování a zobrazení informací
            }
          }
        },
        awards: {
        }
      })
    })
  end


end