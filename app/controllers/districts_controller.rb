class DistrictsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = District.accessible_by(current_ability).ransack(params[:q])
    @districts = @q.result(distinct: true)
  end

  def new
    @district = District.new
  end

  def edit
  end

  def create
    @district = District.new(district_params)

    if @district.save
      redirect_to @district, notice: "District was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @district.update(district_params)
      redirect_to @district, notice: "District was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @district.destroy!
      redirect_to districts_url, notice: "District was successfully destroyed.", status: :see_other
    rescue ActiveRecord::DeleteRestrictionError
      redirect_to districts_url, alert: "District cannot be destroyed while fire departments are still associated."
    end
  end

  private
    def set_district
      @district = District.find(params[:id])
    end

    def district_params
      params.require(:district).permit(:name, :code, :region_id)
    end
end