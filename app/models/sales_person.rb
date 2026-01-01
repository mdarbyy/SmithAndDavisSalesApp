class SalesPerson < ApplicationRecord
  has_many :sales_records
  
  validate :unique_sales_person
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_save :capitalize_sales_person
  before_destroy :find_records
  
  private 
  
  def capitalize_sales_person
    if first_name.present?
      self.first_name = first_name.strip.split.map(&:capitalize).join(" ")
    end

    if last_name.present?
      self.last_name = last_name.strip.split.map(&:capitalize).join(" ")
    end
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