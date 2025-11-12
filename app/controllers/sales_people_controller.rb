class SalesPeopleController < ApplicationController
  before_action :set_sales_person, only: %i[ show edit update destroy ]

  # GET /sales_people or /sales_people.json
  def index
    @sales_people = SalesPerson.all.includes(:sales_records).order(Arel.sql("is_active DESC, first_name ASC, last_name ASC"))
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /sales_people/1 or /sales_people/1.json
  def show
    @sales_records = @sales_person.sales_records.order(id: :desc)
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /sales_people/new
  def new
    @sales_person = SalesPerson.new
  end

  # GET /sales_people/1/edit
  def edit
  end

  # POST /sales_people or /sales_people.json
  def create
    @sales_person = SalesPerson.new(sales_person_params)
    if @sales_person.save
      redirect_to sales_people_path, success: 'Sales Person was created'
    else
      flash.now[:danger] = @sales_person.errors.full_messages.first
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sales_people/1 or /sales_people/1.json
  def update
    if @sales_person.update(sales_person_params)
      redirect_to sales_people_path, success: 'Sales Person was updated'
    else
      flash.now[:danger] = @sales_person.errors.full_messages.first
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /sales_people/1 or /sales_people/1.json
  def destroy
    @sales_person.destroy
    respond_to do |format|
      format.html { redirect_to sales_people_path, success: 'Sales Person was deleted' }
      format.json do
        @sales_person.destroyed? ? head(:no_content) :
        render(json: { errors: @sales_person.errors.full_messages }, status: :unprocessable_entity)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_person
      @sales_person = SalesPerson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sales_person_params
      params.require(:sales_person).permit(:first_name, :last_name, :is_active)
    end
end
