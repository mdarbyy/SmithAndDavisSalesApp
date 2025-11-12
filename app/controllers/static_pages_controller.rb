class StaticPagesController < ApplicationController
  def dashboard

    if params[:start_date].blank? || params[:end_date].blank?
      return
    end

    @start_date = Date.strptime(params[:start_date], '%m/%d/%Y')
    @end_date = Date.strptime(params[:end_date], '%m/%d/%Y')

    @sales_records = SalesRecord.where(sell_date: @start_date..@end_date)
    if @sales_records.count == 0
      redirect_to request.referrer, danger: "No sales were recorded within this date range"
      return
    end

    sales_person_ids = @sales_records.pluck(:sales_person_id).uniq
    @sales_people = SalesPerson.where(id: sales_person_ids)
  end
end
