class RegionsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Region.accessible_by(current_ability).ransack(params[:q])
    @regions = @q.result(distinct: true)
  end

  def new
    @region = Region.new
  end

  def edit
  end

  def create
    @region = Region.new(region_params)

    if @region.save
      redirect_to @region, notice: "Region was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @region.update(region_params)
      redirect_to @region, notice: "Region was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @region.destroy!
      redirect_to regions_url, notice: "Region was successfully destroyed.", status: :see_other
    rescue ActiveRecord::DeleteRestrictionError
      redirect_to regions_url, alert: "Region cannot be destroyed while districts are still associated."
    end
  end

  private
    def set_region
      @region = Region.find(params[:id])
    end

    def region_params
      params.require(:region).permit(:name, :code)
    end
end