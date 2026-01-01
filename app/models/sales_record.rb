class SalesRecord < ApplicationRecord
  belongs_to :sales_person
  
  validates :sell_date, presence: true

  MAX_AMOUNT_SOLD = 20000
  FORMATTED_MAX_AMOUNT_SOLD = ActionController::Base.helpers.number_with_delimiter(MAX_AMOUNT_SOLD)
  validates :amount_sold,
  numericality: {
    only_integer: true,
    less_than_or_equal_to: MAX_AMOUNT_SOLD,
    message: "must be less than or equal to #{FORMATTED_MAX_AMOUNT_SOLD}"
  }

  MAX_HOURS = 24
  FORMATTED_MAX_HOURS = ActionController::Base.helpers.number_with_delimiter(MAX_HOURS)
  validates :sales_floor_hours, :project_hours,
  numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: MAX_HOURS,
    message: "must be less than or equal to #{FORMATTED_MAX_HOURS}"
  }

  before_save :ensure_fields_filled
  before_save :ensure_unique_sales_record

  private

  def ensure_fields_filled
    self.amount_sold       = (amount_sold || 0).round(2)
    self.sales_floor_hours = (sales_floor_hours || 0).round(2)
    self.project_hours     = (project_hours || 0).round(2)
  end

  def ensure_unique_sales_record
    duplicate = SalesRecord
      .where(sales_person_id: sales_person_id, sell_date: sell_date)
      .where.not(id: id)
      .exists?

    if duplicate
      errors.add(:base, "A Sales Record for this Sales Person already exists on that date")
      throw(:abort)
    end
  end
end