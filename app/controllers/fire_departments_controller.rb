class FireDepartmentsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = FireDepartment.accessible_by(current_ability).ransack(params[:q])
    @fire_departments = @q.result(distinct: true)
  end

  # GET /fire_departments/new
  def new
    @fire_department = FireDepartment.new
  end

  def edit
  end

  def create
    @fire_department = FireDepartment.new(fire_department_params)

    if @fire_department.save
      redirect_to @fire_department, notice: "Fire department was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @fire_department.update(fire_department_params)
      redirect_to @fire_department, notice: "Fire department was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @fire_department.destroy!
      redirect_to fire_departments_url, notice: "Fire department was successfully destroyed.", status: :see_other
    rescue ActiveRecord::DeleteRestrictionError
      redirect_to fire_departments_url, alert: "Fire department cannot be destroyed while members are still associated."
    end
  end

  private
  def set_fire_department
    @fire_department = FireDepartment.find(params[:id])
  end

  def fire_department_params
    params.require(:fire_department).permit(:name, :code, :district_id, :address)
  end
end
