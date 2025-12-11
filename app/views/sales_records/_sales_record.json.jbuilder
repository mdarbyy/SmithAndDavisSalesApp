json.extract! sales_record, :id, :sell_date, :total, :items_sold, :sales_floor_hours, :project_hours, :sales_person_id, :created_at, :updated_at
json.url sales_record_url(sales_record, format: :json)