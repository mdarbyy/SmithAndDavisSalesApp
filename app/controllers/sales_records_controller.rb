class SalesRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sales_record, only: %i[ show edit update destroy ]

  # GET /sales_records or /sales_records.json
  def index
    @limit = 30
    offset = params[:offset].to_i || 0
    @sales_records = SalesRecord.includes(:sales_person)
    .limit(@limit)
    .offset(offset)
    .order(id: :desc)
    @total_records = SalesRecord.all.count

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /sales_records/1 or /sales_records/1.json
  def show
  end

  # GET /sales_records/new
  def new
    if SalesPerson.count == 0
      redirect_to sales_records_path, danger: 'Add a Sales Person to start making Sales Records'
      return
    end
    
    @sales_record = SalesRecord.new
  end

  # GET /sales_records/1/edit
  def edit
    session[:return_to] = request.referer
  end

  # POST /sales_records or /sales_records.json
  def create
    @sales_record = SalesRecord.new(sales_record_params.except(:sell_date))

    # Force correct U.S. month/day/year parsing
    @sales_record.sell_date = Date.strptime(sales_record_params[:sell_date], '%m/%d/%Y')

    if @sales_record.save
      redirect_to sales_records_path, success: 'Sales Record was created'
    else
      flash.now[:danger] = @sales_record.errors.full_messages.first
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sales_records/1 or /sales_records/1.json
  def update
    if params[:sales_record][:sell_date].present?
      params[:sales_record][:sell_date] = Date.strptime(params[:sales_record][:sell_date], '%m/%d/%Y')
    end
    
    if @sales_record.update(sales_record_params)
      redirect_to(session.delete(:return_to) || sales_records_path, success: 'Sales Record was updated')
    else
      flash.now[:danger] = @sales_record.errors.full_messages.first
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /sales_records/1 or /sales_records/1.json
  def destroy
    @sales_record.destroy
    respond_to do |format|
      format.html { redirect_to sales_records_path, success: 'Sales Record was deleted' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sales_record
    @sales_record = SalesRecord.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def sales_record_params
    params.require(:sales_record).permit(:sell_date, :amount_sold, :sales_floor_hours, :project_hours, :sales_person_id)
  end
end