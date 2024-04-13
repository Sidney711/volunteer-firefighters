class MembershipsController < ApplicationController
  load_and_authorize_resource

  # GET /memberships/new
  def new
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships
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


  # PATCH/PUT /memberships/1
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


  # DELETE /memberships/1
  def destroy
    @membership.destroy!
    redirect_to memberships_url, notice: "Membership was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def membership_params
      params.require(:membership).permit(:start_date, :fire_department_id, :account_id, :role, :status)
    end
end
