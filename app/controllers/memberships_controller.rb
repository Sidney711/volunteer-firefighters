class MembershipsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Membership.accessible_by(current_ability).ransack(params[:q])
    @memberships = @q.result.includes(:account, :fire_department).distinct
  end

  def new
    @membership = Membership.new
  end

  def edit
  end

  def create
    @membership = Membership.new(membership_params)

    if rodauth.rails_account.memberships.where(fire_department_id: @membership.fire_department_id, role: 1).exists? || rodauth.rails_account.is_super_admin
      if @membership.save
        redirect_to @membership, notice: "Membership was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to memberships_url, alert: "You do not have permission to create memberships for this fire department."
    end
  end

  def update
    if rodauth.rails_account.memberships.where(fire_department_id: membership_params[:fire_department_id], role: 1).exists? || rodauth.rails_account.is_super_admin
      if @membership.update(membership_params)
        redirect_to @membership, notice: "Membership was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to memberships_url, alert: "You do not have permission to update memberships for this fire department."
    end
  end

  def destroy
    @membership.destroy!
    redirect_to memberships_url, notice: "Membership was successfully destroyed.", status: :see_other
  end

  private
    def set_membership
      @membership = Membership.find(params[:id])
    end

    def membership_params
      params.require(:membership).permit(:start_date, :fire_department_id, :account_id, :role, :status)
    end
end