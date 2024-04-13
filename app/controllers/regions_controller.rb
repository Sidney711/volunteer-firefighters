class RegionsController < ApplicationController
  before_action :authenticate
  load_and_authorize_resource

  # GET /regions/new
  def new
    @region = Region.new
  end

  # GET /regions/1/edit
  def edit
  end

  # POST /regions
  def create
    @region = Region.new(region_params)

    if @region.save
      redirect_to @region, notice: "Region was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /regions/1
  def update
    if @region.update(region_params)
      redirect_to @region, notice: "Region was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /regions/1
  def destroy
    begin
      @region.destroy!
      redirect_to regions_url, notice: "Region was successfully destroyed.", status: :see_other
    rescue ActiveRecord::DeleteRestrictionError
      redirect_to regions_url, alert: "Region cannot be destroyed while districts are still associated."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_region
      @region = Region.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def region_params
      params.require(:region).permit(:name, :code)
    end
end
