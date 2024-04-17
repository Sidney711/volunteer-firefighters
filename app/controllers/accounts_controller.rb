class AccountsController < ApplicationController
  load_and_authorize_resource

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
    if !rodauth.rails_account.is_super_admin && account_params[:is_super_admin]
      redirect_to accounts_url, alert: "You do not have permission to make someone superadmin."
    else
      if @account.update(account_params)
        update_account_awards
        redirect_to @account, notice: 'Account was successfully updated.'
      else
        render :edit, alert: 'Account was not updated.'
      end
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

  def update_account_awards
    account_awards_params[:account_awards_attributes].each do |_, attributes|
      award_id = attributes[:award_id]
      scheduled_at = attributes[:scheduled_at]
      if attributes[:_destroy] == "1" # Kontrola, zda je označeno k odstranění
        # Pokud je ocenění označeno k odstranění, odstraníme ho, pokud existuje
        account_award = @account.account_awards.find_by(award_id: award_id)
        account_award.destroy if account_award # Pokud ocenění existuje, odstraníme ho
      elsif scheduled_at.present? && !attributes[:id].present?
        # Pokud je zadáno scheduled_at, odložíme přidělení ocenění pomocí Active Job
        AwardAssignmentJob.set(wait_until: DateTime.parse(scheduled_at)).perform_later(@account, award_id)
      else
        # Pokud není zadáno scheduled_at, aktualizujeme pouze dané ocenění, pokud existuje
        account_award = @account.account_awards.find_by(id: attributes[:id])

        if account_award
          account_award.update(award_id: award_id, scheduled_at: nil)
        else
          @account.account_awards.create(award_id: award_id)
        end
      end
    end
  end




end