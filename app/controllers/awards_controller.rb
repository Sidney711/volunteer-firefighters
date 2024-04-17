class AwardsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Award.accessible_by(current_ability).ransack(params[:q])
    @awards = @q.result(distinct: true)
  end

  # GET /awards/new
  def new
    @award = Award.new
  end

  # GET /awards/1/edit
  def edit
  end

  # POST /awards
  def create
    @award = Award.new(award_params)

    if @award.save
      redirect_to @award, notice: "Award was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /awards/1
  def update
    if @award.update(award_params)
      redirect_to @award, notice: "Award was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @award.destroy!
      redirect_to awards_url, notice: "Award was successfully destroyed.", status: :see_other
    rescue ActiveRecord::DeleteRestrictionError
      redirect_to awards_url, alert: "Award cannot be destroyed while members are still associated."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_award
      @award = Award.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def award_params
      params.require(:award).permit(:name, :award_type, :image, :dependent_award_id, :minimum_service_years, :minimum_age)
    end
end
