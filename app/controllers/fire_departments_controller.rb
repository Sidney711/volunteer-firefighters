class FireDepartmentsController < ApplicationController
  before_action :set_fire_department, only: %i[ show edit update destroy ]

  # GET /fire_departments
  def index
    @fire_departments = FireDepartment.all
  end

  # GET /fire_departments/1
  def show
  end

  # GET /fire_departments/new
  def new
    @fire_department = FireDepartment.new
  end

  # GET /fire_departments/1/edit
  def edit
  end

  # POST /fire_departments
  def create
    @fire_department = FireDepartment.new(fire_department_params)

    if @fire_department.save
      redirect_to @fire_department, notice: "Fire department was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /fire_departments/1
  def update
    if @fire_department.update(fire_department_params)
      redirect_to @fire_department, notice: "Fire department was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /fire_departments/1
  def destroy
    @fire_department.destroy!
    redirect_to fire_departments_url, notice: "Fire department was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fire_department
      @fire_department = FireDepartment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fire_department_params
      params.require(:fire_department).permit(:name, :code, :district_id, :address)
    end
end