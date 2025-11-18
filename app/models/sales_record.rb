class SalesRecord < ApplicationRecord
  belongs_to :sales_person
  validates :sell_date, presence: true
  before_create :ensure_unique_sales_record
  before_create :ensure_fields_filled
  before_update :ensure_unique_sales_record
  before_update :ensure_fields_filled

  private

  def ensure_fields_filled
    self.amount_sold       ||= 0
    self.items_sold        ||= 0
    self.sales_floor_hours ||= 0
    self.project_hours     ||= 0
  end

  def ensure_unique_sales_record
    
    duplicate = if persisted?
      SalesRecord.where(sales_person_id: sales_person_id, sell_date: sell_date)
      .where.not(id: id)
      .exists?
    else
      SalesRecord.exists?(sales_person_id: sales_person_id, sell_date: sell_date)
    end
    
    if duplicate
      errors.add(:base, "A Sales Record for this Sales Person already exists on that date")
      throw(:abort)
    end
  end
end