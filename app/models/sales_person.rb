class SalesPerson < ApplicationRecord
  validate :unique_sales_person
  validates :first_name, presence: true
  validates :last_name, presence: true
  before_create :capitalize_sales_person
  before_update :capitalize_sales_person
  before_destroy :find_records
  has_many :sales_records

  private 
  
  def capitalize_sales_person
    self.first_name = first_name.strip.capitalize if first_name.present?
    self.last_name  = last_name.strip.capitalize if last_name.present?
  end
  
  def find_records
    if sales_records.exists?
      errors.add(:base, "There are Sales Records for this Sales Person")
      throw(:abort)
    end
  end
  
  def unique_sales_person
    
    duplicate = if persisted?
      # For updates, ignore the current record
      SalesPerson.where(first_name: first_name.capitalize, last_name: last_name.capitalize).where.not(id: id).exists?
    else
      # For new records
      SalesPerson.exists?(first_name: first_name.capitalize, last_name: last_name.capitalize)
    end

    if duplicate
      errors.add(:base, "This Sales Person already exists")
    end  

  end
end
